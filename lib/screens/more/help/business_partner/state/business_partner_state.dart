import 'package:image_picker/image_picker.dart';
import 'package:laundryday/models/services_model.dart';


class BusinessPartnerState {
  List<ServicesModel> items = [];
  int? currentStep;
  XFile? image;
  String?categoryType;
  List<ServicesModel> selectedItems = [];

  BusinessPartnerState(
      {required this.items,
      required this.currentStep,
      required this.categoryType,
      required this.selectedItems,
      required this.image});

  BusinessPartnerState copyWith({
    List<ServicesModel>? items,
    XFile? image,
    int? currentStep,
    String? categoryType,
    List<ServicesModel>? selectedItems,
  }) {
    return BusinessPartnerState(
      items: items ?? this.items,
      image: image ?? this.image,
      currentStep: currentStep??this.currentStep,
      categoryType: categoryType ?? this.categoryType,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
