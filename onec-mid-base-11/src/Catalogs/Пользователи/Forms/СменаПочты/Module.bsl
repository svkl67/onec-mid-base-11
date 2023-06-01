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
	
	Пользователь = Параметры.Пользователь;
	ПарольПользователяСервиса = Параметры.ПарольПользователяСервиса;
	СтараяПочта = Параметры.СтараяПочта;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СменитьПочту(Команда)
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ТекстВопроса = "";
	Если Не ЗначениеЗаполнено(СтараяПочта) Тогда
		ТекстВопроса =
			НСтр("ru = 'Адрес электронной почты пользователя сервиса изменен.
			           |Владельцы и администраторы абонента больше не смогут изменять параметры пользователя.'")
			+ Символы.ПС
			+ Символы.ПС;
	КонецЕсли;
	ТекстВопроса = ТекстВопроса + НСтр("ru = 'Выполнить изменение адреса электронной почты?'");
	
	ПоказатьВопрос(
		Новый ОписаниеОповещения("СменитьПочтуПродолжение", ЭтотОбъект),
		ТекстВопроса,
		РежимДиалогаВопрос.ДаНетОтмена);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СоздатьЗапросНаСменуПочты()
	
	ИнтеграцияПодсистемБСП.ПриСозданииЗапросаНаСменуПочты(НоваяПочта,
		Пользователь, ПарольПользователяСервиса);
	
КонецПроцедуры

&НаКлиенте
Процедура СменитьПочтуПродолжение(Ответ, Контекст) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		
		Попытка
			СоздатьЗапросНаСменуПочты();
		Исключение
			ПарольПользователяСервиса = "";
			ПодключитьОбработчикОжидания("ЗакрытьФорму", 0.1, Истина);
			ВызватьИсключение;
		КонецПопытки;
		
		ПоказатьПредупреждение(
			Новый ОписаниеОповещения("СменитьПочтуЗавершение", ЭтотОбъект, Контекст),
			НСтр("ru = 'На указанный адрес отправлено письмо с запросом на подтверждение.
			           |Почта будет изменена только после подтверждения запроса пользователем.'"));
		
	ИначеЕсли Ответ = КодВозвратаДиалога.Нет Тогда
		СменитьПочтуЗавершение(Контекст);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СменитьПочтуЗавершение(Контекст) Экспорт
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму()
	
	Закрыть(ПарольПользователяСервиса);
	
КонецПроцедуры

#КонецОбласти
