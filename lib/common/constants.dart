const String kApiKey = "3279e35e3c2c4685af527c15ccff25ff";
const String kAllLatestApi = 'https://openexchangerates.org/api/latest.json?app_id=$kApiKey';
const String kAllCurrencyApi = 'https://openexchangerates.org/api/currencies.json?app_id=$kApiKey';
// String currencyConvertApi(amount, toCurrency, fromCurrency) => 'https://openexchangerates.org/api/convert/$amount/$toCurrency/$fromCurrency?app_id=apikey=$kApiKey';