import 'package:flutter/widgets.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/value_manager.dart';

enum OrderStatusesList {
  pending,
  accepted,
  received,
  atCustomer,
  delivered,
  collectingFromCustomer,
  paymentCollected,
  secondTripAssigned
}

enum PaymentStatuses {
  paid,
  unpaid,
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

    case OrderStatusesList.secondTripAssigned:
      return 'second-trip-assigned';
    default:
      return 'Unknown status';
  }
}

String getStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';
    case 'accepted':
      return 'Agent arrived to Laundry.';
    case 'received':
      return 'Agent Recived the order.';
    case 'at_customer':
      return 'Agent near you';
    case 'delivered':
      return 'Order is completed';
    case 'canceled':
      return 'Order is canceled';
    default:
      return 'Unknown order status';
  }
}

String getPickupOrderStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';
    case 'accepted':
      return 'Agent arrived to Laundry.';
    case 'received':
      return 'Agent Recived the order.';
    case 'at_customer':
      return 'Agent near you';
    case 'delivered':
      return 'Order is completed';
    case 'canceled':
      return 'Order is canceled';
    default:
      return 'Unknown order status';
  }
}

String getStatusImage({required String status}) {
  switch (status) {
    case 'pending':
      return AssetImages.pendingStatus;
    case 'accepted':
      return AssetImages.acceptedStatus;

    case 'received':
      return AssetImages.recivedStatus;

    case 'collecting-from-customer':
      return AssetImages.collectingFromCustomer;
    case 'delivering-to-store':
      return AssetImages.invoice;
    case 'delivered':
      return AssetImages.deliveredStatus;

    case 'at_customer':
      return AssetImages.atCustomerStatus;

    default:
      return AssetImages.pendingStatus;
  }
}

String getRoundTripOrderStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';
    case 'accepted':
      return 'Approach You';
    case 'collecting-from-customer':
      return 'Items Collected';
    case 'delivering-to-store':
      return 'The Invoice has been Issued';

    case 'payment-collected':
      return 'Payment Successful';
    case 'second-trip-assigned':
      return "Items servicing";
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

    case 'payment-collected':
      return 'Payment Successful';
    case 'second-trip-assigned':
      return "Your items have been given to the laundry for servicing.";
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
    case 'accepted':
      return 'Delivery Agent Arrived to store and he will get your order soon';
    case 'received':
      return 'Delivery Agent  recieved order, he is on his way.';
    case 'at_customer':
      return 'Delivery Agent near you , be ready to get your order.';

    case 'delivered':
      return 'Your Order is completed, we hope to see you again';
    case 'canceled':
      return 'Order is canceled';
    default:
      return 'Unknown order status';
  }
}
 String getOrderStatusMessage({required String status}) {
    switch (status) {
      case 'pending':
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
      default:
        return 'Unknown order status';
    }
  }