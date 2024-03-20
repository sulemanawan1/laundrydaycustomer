import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';

class BusinessPartnerState {
  List<String> items = [];
  CategoryType categoryType;
  List<String> selectedItems = [];

  BusinessPartnerState(
      {required this.items,
      required this.categoryType,
      required this.selectedItems});
}
