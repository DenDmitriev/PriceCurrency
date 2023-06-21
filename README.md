# PriceCurrency
Курсы валют и конвертер цен

![Review](https://github.com/DenDmitriev/PriceCurrency/assets/65191747/210a3c76-5215-4ac5-9aa7-fb4d8c7e34fb)

# Обзор
Приложение iOS для просмотра валютных курсов и конвертации цен. Состоит из двух вкладок. На первой можно [получить курс](#курс) выбранной валюты в других. На второй можно [конвертировать](#конвертер-валют) цены между двумя валютами.

## Курс
Для выбора нужного курса, нужно ввести код валюты в панели и список автоматически покажется ниже.

![RatePanel](https://github.com/DenDmitriev/PriceCurrency/assets/65191747/3772a23f-cd43-4a77-97f8-c56166f7c0f5)

Чтоб было проще ориентироваться, есть фильтр списка валют. Нажав кнопку фильтр и выделив нужные коды, список обновится и сервис покажет выбранные. 

![RateAndFilter](https://github.com/DenDmitriev/PriceCurrency/assets/65191747/dd8d80b8-8305-43ee-a664-b959b4d5631b)

Над таблицей курсов есть таймер, который показывает давность полученных даных.

![TimerRate](https://github.com/DenDmitriev/PriceCurrency/assets/65191747/3b0f989f-15cf-4a0b-9fd6-d1e8949e67c2)

Реализует это сервис [Exchange Rate API](#exchangerateapi) https://api.exchangerate.host/latest?base=rub

## Конвертер валют
Пользователь вводит коды валют и цену в левой валюте. Далее происходит автоматическая конвертация цены и результат выводит под введеной ценой. Реализует это сервис [Exchange Rate API](#exchangerateapi) https://api.exchangerate.host/convert?from=USD&to=EUR&amount=1

![CoverterPanel](https://github.com/DenDmitriev/PriceCurrency/assets/65191747/a1fd76f5-48c3-4cc9-a24d-048d2d1dbd6e)

Под результатом приводится график динамики курса этих валют. 

![HistoryRateChart](https://github.com/DenDmitriev/PriceCurrency/assets/65191747/70b5d923-e90b-4f38-b4d3-90d87e2293f1)

# Реализация
- [SwiftUI](#)
- [Combine](#)
- [ExchangeRateAPI](#exchangerateapi)

## SwiftUI
Интерфейс написан на SwiftUI, он легко обноляемый при использовании предикатов.

## Combine
 - Используется в интерфейсе, предикаты. 
https://github.com/DenDmitriev/PriceCurrency/blob/f940286084ba74d5edd199b603114034b4590829/PriceCurrency/PriceCurrency/Flow/Converter/View/ConverterView.swift#L13-L19

 - Запросы в сеть.
https://github.com/DenDmitriev/PriceCurrency/blob/f940286084ba74d5edd199b603114034b4590829/PriceCurrency/PriceCurrency/Core/Service/ExchangeRateAPI.swift#L62-L86

## ExchangeRateAPI
Для сервиса полкчения данных используется [Exchange Rate API](https://exchangerate.host/#/#docs).
https://github.com/DenDmitriev/PriceCurrency/blob/f940286084ba74d5edd199b603114034b4590829/PriceCurrency/PriceCurrency/Core/Service/ExchangeRateAPI.swift#L114-L172
