///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types


#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(СсылкаВарианта, ПараметрыВыполненияКоманды)
	Вариант = СсылкаВарианта;
	Форма = ПараметрыВыполненияКоманды.Источник;
	Если ТипЗнч(Форма) = Тип("ФормаКлиентскогоПриложения") Тогда
		Если Форма.ИмяФормы = "Справочник.ВариантыОтчетов.Форма.ФормаСписка" Тогда
			Вариант = Форма.Элементы.Список.ТекущиеДанные;
		ИначеЕсли Форма.ИмяФормы = "Справочник.ВариантыОтчетов.Форма.ФормаЭлемента" Тогда
			Вариант = Форма.Объект;
		КонецЕсли;
	Иначе
		Форма = Неопределено;
	КонецЕсли;
	
	ВариантыОтчетовКлиент.ОткрытьФормуОтчета(Форма, Вариант);
КонецПроцедуры

#КонецОбласти
