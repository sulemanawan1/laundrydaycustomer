class OrderStatusHelper {
  OrderStatusHelper._();

  static String getOrderStatusMessage({required String status}) {
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
}

