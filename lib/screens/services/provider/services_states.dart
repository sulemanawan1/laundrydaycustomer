import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

class ServicesStates {
  List<Order> order;
  LatLng? latLng;
  servicemodel.Datum? selectedService;

  ServicesStates({required this.order, this.latLng, this.selectedService});

  ServicesStates copyWith({
    List<Order>? order,
    servicemodel.Datum? selectedService,
    LatLng? latLng,
  }) {
    return ServicesStates(
      order: order ?? this.order,
      selectedService: selectedService ?? this.selectedService,
      latLng: latLng ?? this.latLng,
    );
  }
}
