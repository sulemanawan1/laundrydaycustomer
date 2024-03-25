import 'package:image_picker/image_picker.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/more/help/business_partner/models/bussiness_partner_model.dart';

class BusinessPartnerState {
  

  List<ServicesModel> items = [];
  int currentStep;
    int regionId;

    String type;


  XFile? image;
  String? categoryType;
  List<ServicesModel> selectedItems = [];
  List<LaundryBusinessModel> laundriesList = [];

  BusinessPartnerState(
      {required this.items,
      required this.currentStep,
      required this.type,
      required this.categoryType,
      required this.selectedItems,
      required this.image,
      required this.regionId,
      required this.laundriesList
      });

  BusinessPartnerState copyWith({
    List<ServicesModel>? items,
    XFile? image,
    int? currentStep,
    String? categoryType,
        String? type,

    int? regionId,
    List<ServicesModel>? selectedItems,
      List<LaundryBusinessModel>? laundriesList 

  }) {
    return BusinessPartnerState(
      regionId: regionId??this.regionId,
      items: items ?? this.items,
      image: image ?? this.image,
      type: type??this.type,
      currentStep: currentStep ?? this.currentStep,
      categoryType: categoryType ?? this.categoryType,
      selectedItems: selectedItems ?? this.selectedItems,
      laundriesList: laundriesList??this.laundriesList
    );
  }
}
