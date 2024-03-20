import 'package:laundryday/models/order_status.dart';
import 'package:location/location.dart';

class OrderProcessStates {
  List<OrderStatus> orderStatusList;
  int orderStatus;
  LocationData? currentLocation;

  OrderProcessStates({
    required this.orderStatusList,
    required this.orderStatus,

    required this.currentLocation
  });

  OrderProcessStates copyWith({
    List<OrderStatus>? orderStatusList,
    int? orderStatus,
    LocationData? currentLocation

  }) {
    return OrderProcessStates(
      orderStatusList: orderStatusList ?? this.orderStatusList,
      orderStatus: orderStatus ?? this.orderStatus,
      currentLocation: currentLocation?? currentLocation
    );
  }
}
