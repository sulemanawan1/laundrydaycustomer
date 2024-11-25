import 'package:laundryday/models/google_laundry_model.dart';
import 'package:laundryday/models/laundry_by_area.model.dart'
    as laundrybyareamodel;
import 'package:laundryday/models/service_timings_model.dart'
    as servicetimingmodel;

class LaundriesStates {
  GoogleLaundryModel? selectedLaundry;
  laundrybyareamodel.Datum selectedLaundryByArea;
  servicetimingmodel.Datum? serviceTiming;
  LaundriesStates({
    this.selectedLaundry,
    this.serviceTiming,
    required this.selectedLaundryByArea,
  });

  LaundriesStates copyWith({
    GoogleLaundryModel? selectedLaundry,
    laundrybyareamodel.Datum? selectedLaundryByArea,
    servicetimingmodel.Datum? serviceTiming,
  }) {
    return LaundriesStates(
      selectedLaundryByArea:
          selectedLaundryByArea ?? this.selectedLaundryByArea,
      selectedLaundry: selectedLaundry ?? this.selectedLaundry,
      serviceTiming: serviceTiming ?? this.serviceTiming,
    );
  }
}
