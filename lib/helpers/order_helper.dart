import 'package:flutter/widgets.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/value_manager.dart';

enum OrderScreenType { delivery_pickup, normal }

enum OrderStatusesList {
  pending,
  accepted,
  rejected,
  received,
  atCustomer,
  delivered,
  readyForDelivery,
  collectingFromCustomer,
  paymentCollected,
  agentNotFound
}

enum PaymentStatuses {
  paid,
  unpaid,
}

String? getOrderNowImage({required String serviceName}) {
  if (serviceName.toLowerCase() == 'clothes') {
    return "assets/order_now_clothes.jpeg";
  } else if (serviceName.toLowerCase() == 'blankets') {
    return "assets/order_now_blankets.jpeg";
  }
  return null;
}

enum OrderType { pickup, roundTrip, unknown }

getOrderType({required String orderType}) {
  switch (orderType) {
    case 'pickup':
      return OrderType.pickup;

    case 'round-trip':
      return OrderType.roundTrip;

    default:
      return OrderType.unknown;
  }
}

Widget StatusImage({required String status}) {
  return Center(
    child: Image.asset(
      getStatusImage(status: status),
      height: AppSize.s95,
    ),
  );
}

String getPickupStatus({required OrderStatusesList orderStatus}) {
  switch (orderStatus) {
    case OrderStatusesList.pending:
      return 'pending';

    case OrderStatusesList.accepted:
      return 'accepted';
    case OrderStatusesList.received:
      return 'received';

    case OrderStatusesList.atCustomer:
      return 'at_customer';

    case OrderStatusesList.readyForDelivery:
      return 'ready_for_delivery';

    case OrderStatusesList.agentNotFound:
      return 'agent_not_found';

    default:
      return 'Unknown status';
  }
}

String getRoundTripStatus({required OrderStatusesList orderStatus}) {
  switch (orderStatus) {
    case OrderStatusesList.pending:
      return 'pending';

    case OrderStatusesList.accepted:
      return 'accepted';

    case OrderStatusesList.received:
      return 'received';
    case OrderStatusesList.collectingFromCustomer:
      return 'collecting-from-customer';

    case OrderStatusesList.delivered:
      return 'delivered';
    case OrderStatusesList.atCustomer:
      return 'at_customer';
    case OrderStatusesList.paymentCollected:
      return 'payment-collected';

    case OrderStatusesList.readyForDelivery:
      return 'ready_for_delivery';

    default:
      return 'Unknown status';
  }
}

//

String getPickupOrderStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';
    case 'rejected':
      return 'Searching for Courier';
    case 'accepted':
      return 'Agent arrived to Laundry.';
    case 'received':
      return 'Agent Recived the order.';
    case 'ready_for_delivery':
      return 'Your Order is ready for Pickup.';
    case 'at_customer':
      return 'Agent near you';
    case 'delivered':
      return 'Order is completed';
    case 'canceled':
      return 'Order is canceled';
    case 'agent_not_found':
      return 'Agent Not Found.';
    default:
      return 'Unknown order status';
  }
}

String getStatusImage({required String status}) {
  switch (status) {
    case 'pending':
      return AssetImages.pendingStatus;

    case 'rejected':
      return AssetImages.pendingStatus;
    case 'accepted':
      return AssetImages.acceptedStatus;

    case 'received':
      return AssetImages.recivedStatus;

    case 'collecting-from-customer':
      return AssetImages.collectingFromCustomer;

    case 'ready_for_delivery':
      return AssetImages.check;
    case 'delivering-to-store':
      return AssetImages.invoice;
    case 'delivered':
      return AssetImages.deliveredStatus;

    case 'at_customer':
      return AssetImages.atCustomerStatus;

    case 'agent_not_found':
      return AssetImages.notFound;

    default:
      return AssetImages.pendingStatus;
  }
}

String getRoundTripOrderStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';
    case 'rejected':
      return 'Searching for Courier';
    case 'accepted':
      return 'Approach You';
    case 'collecting-from-customer':
      return 'Items Collected';
    case 'delivering-to-store':
      return 'The Invoice has been Issued';
    case 'ready_for_delivery':
      return 'Your Order is ready for Pickup.';
    case 'payment-collected':
      return 'Payment Successful';
    case 'received':
      return "Item Received";
    case 'at_customer':
      return "Agent arrived";

    case 'delivered':
      return 'Your Order is completed, we hope to see you again';
    default:
      return 'Unknown order status';
  }
}

String getRoundTripOrderDescription({required String status}) {
  switch (status) {
    case 'pending':
      return """Patience always pay off.kindly allow us some time while we are looking for available courier.""";
    case 'accepted':
      return 'Delivery Agent is coming to pickup your clothes';
    case 'collecting-from-customer':
      return 'The Agent Collected the Items';

    case 'delivering-to-store':
      return 'The Agent will recieve your order when service time is completed';
    case 'ready_for_delivery':
      return 'Your Order is ready for Pickup.';
    case 'payment-collected':
      return 'Payment Successful';

    case 'received':
      return "The agent has picked up your item from the laundry and will deliver it to you shortly.";

    case 'at_customer':
      return "The Agent has arrived at your given location.";

    case 'delivered':
      return 'Your Order is completed, we hope to see you again';

    case 'canceled':
      return 'Order is canceled';
    default:
      return 'Unknown order status';
  }
}

String getOrderDescription({required String status}) {
  switch (status) {
    case 'pending':
      return """Patience always pay off.kindly allow us some time while we are looking for available courier.""";

    case 'rejected':
      return """Patience always pay off.kindly allow us some time while we are looking for available courier.""";

    case 'accepted':
      return 'Delivery Agent Arrived to store and he will get your order soon';
    case 'received':
      return 'Delivery Agent  recieved order, he is on his way.';
    case 'at_customer':
      return 'Delivery Agent near you , be ready to get your order.';
    case 'ready_for_delivery':
      return 'Your Order is ready for Pickup.';
    case 'delivered':
      return 'Your Order is completed, we hope to see you again';
    case 'canceled':
      return 'Order is canceled';

    case 'agent_not_found':
      return 'Agent Not Found.Try Again Later.';
    default:
      return 'Unknown order status';
  }
}

String getOrderStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';

    case 'rejected':
      return 'Searching for Courier';

    case 'accepted':
      return 'Delivery Agent arrived to Laundry.';
    case 'received':
      return 'Delivery Agent Recived the order.';
    case 'at_customer':
      return 'Delivery Agent near you';
    case 'delivered':
      return 'Order is delivered';
    case 'canceled':
      return 'Order is canceled';
    case 'ready_for_delivery':
      return 'Your Order is ready for Pickup';

    case 'agent_not_found':
      return 'Agent Not Found.Try Again Later.';
    default:
      return 'Unknown order status';
  }
}
