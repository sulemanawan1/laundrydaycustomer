import 'dart:ui';
class SubscriptionPlan {
  final String name;
  final String price;
  final int duration;
  final String features;
  final Color color;

  SubscriptionPlan({
    required this.name,
    required this.price,
    required this.duration,
    required this.features,
    required this.color,
  });
}
