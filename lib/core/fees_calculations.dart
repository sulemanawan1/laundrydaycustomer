const double varPercentage = (15 / 100);

// Pickup
double deliveryFeesPickup = 6.0;
double operationFeesPickup = 7.0;


// Round Trip - Pickup from Home Deliver to Laundry

double deliveryFeesdeliverToLaundry = 7.0;
double operationFeesdeliverToLaundry = 7.0;

// Round Trip - Pickup from Home Deliver to Laundry & Pickup from Laundry Delivever to Home

double deliveryFeesFullOrder = 13.0;
double operationFeesFullOrder = 7.0;

double getVat(
    {required double deliveryFee,
    required double operationFee,
    double additionalOperationFee = 0.0,
    double additionalDeliveryFee = 0.0}) {
  double total = (deliveryFee +
      operationFee +
      additionalOperationFee +
      additionalDeliveryFee);

  double vat = varPercentage * total;

  return vat;
}

double getTotal(
    {required double deliveryFee,
    required double operationFee,
    double additionalOperationFee = 0.0,
    double additionalDeliveryFee = 0.0}) {
  double total = (deliveryFee +
      operationFee +
      additionalOperationFee +
      additionalDeliveryFee);

  return total;
}

double getTotalIncludedVat(
    {required double deliveryFee,
    required double operationFee,
    double additionalOperationFee = 0.0,
    double additionalDeliveryFee = 0.0}) {
  double total = (deliveryFee +
      operationFee +
      additionalOperationFee +
      additionalDeliveryFee);

  double vat = varPercentage * total;

  double totalIncludedVat = total + vat;

  return totalIncludedVat;
}
