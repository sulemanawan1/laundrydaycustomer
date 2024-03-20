class OrderStatus {
   int id;
   String description;
   int orderId;
   int status;
   bool isActive;
   DateTime createdAt;

  OrderStatus({
    required this.id,
      required this. description,

    required this.orderId,
    required this.status,
    required this.isActive,
    required this.createdAt,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'] as int,
      description: json['description'] as String,
      orderId: json['orderId'] as int,
      status: json['status'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description':description,
      'orderId': orderId,
      'status': status,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
