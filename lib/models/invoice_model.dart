class InvoiceModel {
  final String title;
  final String subtitle;

    final String buildingNo;

  final String invoiceDate;
  final String taxIdentificationNumber;
  final String invoiceNumber;
  final List<String> invoiceDetails;
  final double deliveryFees;
  final double serviceFees;
  final double subTotal;
  final double vat;
  final double total;

  InvoiceModel({
    required this.title,
    required this.subtitle,
    required this.buildingNo,
    required this.invoiceDate,
    required this.taxIdentificationNumber,
    required this.invoiceNumber,
    required this.invoiceDetails,
    required this.deliveryFees,
    required this.serviceFees,
    required this.subTotal,
    required this.vat,
    required this.total,
  });
}
