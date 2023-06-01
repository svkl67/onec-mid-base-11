///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Заголовок = Параметры.Заголовок;
	
	МассивПредставлений = ?(Параметры.ЭтоОтбор,
		СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Параметры.Назначение, ", "),
		Неопределено);
	
	Если Параметры.ВыбиратьПользователей Тогда
		ДобавитьСтрокуТипа(Справочники.Пользователи.ПустаяСсылка(), Тип("СправочникСсылка.Пользователи"), МассивПредставлений);
	КонецЕсли;
	
	Если ВнешниеПользователи.ИспользоватьВнешнихПользователей() Тогда
		
		ПустыеСсылки = ПользователиСлужебныйПовтИсп.ПустыеСсылкиТиповОбъектовАвторизации();
		Для Каждого ПустаяСсылка Из ПустыеСсылки Цикл
			ДобавитьСтрокуТипа(ПустаяСсылка, ТипЗнч(ПустаяСсылка), МассивПредставлений);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	Закрыть(Назначение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ДобавитьСтрокуТипа(Значение, Тип, МассивПредставлений)
	
	Представление = Метаданные.НайтиПоТипу(Тип).Синоним;
	
	Если Параметры.ЭтоОтбор Тогда
		Пометка = МассивПредставлений.Найти(Представление) <> Неопределено;
	Иначе
		ПараметрыОтбора = Новый Структура;
		ПараметрыОтбора.Вставить("ТипПользователей", Значение);
		НайденныеСтроки = Параметры.Назначение.НайтиСтроки(ПараметрыОтбора);
		Пометка = НайденныеСтроки.Количество() = 1;
	КонецЕсли;
	
	Назначение.Добавить(Значение, Представление, Пометка);
	
КонецПроцедуры

#КонецОбласти