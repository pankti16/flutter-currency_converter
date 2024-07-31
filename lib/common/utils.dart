String convertUsdToAny(double rate, String amount) {
  if (amount == null || amount.isEmpty) {
    amount = "1";
  }
  return (double.parse(amount) * rate).toStringAsFixed(2);
}

String convertAnyToAny(double fromRate, double toRate, String amount) {
  if (amount == null || amount.isEmpty) {
    amount = "1";
  }
  return ((double.parse(amount) * toRate) / fromRate).toStringAsFixed(2);
}