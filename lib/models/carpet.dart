class Carpet {
  int? id;
  int? laundryId;
  String? name;
  String? image;
  int? quantity;
  double? initialCharges;
  double? charges;
  double? length;
  int? prefixLength;
  int? postfixLength;
  double? width;
  int? prefixWidth;
  int? postfixWidth;
  double? size;
  String? category;

  Carpet({
    this.id,
    this.laundryId,
    this.name,
    this.image,
    this.quantity,
    this.initialCharges,
    this.charges,
    this.length,
    this.prefixLength,
    this.postfixLength,
    this.width,
    this.prefixWidth,
    this.postfixWidth,
    this.size,
    this.category,
  });

  Carpet.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        laundryId = json['laundryId'],
        name = json['name'],
        image = json['image'],
        quantity = json['quantity'],
        initialCharges = json['initialCharges'],
        charges = json['charges'],
        length = json['length'],
        prefixLength = json['prefixLength'],
        postfixLength = json['postfixLength'],
        width = json['width'],
        prefixWidth = json['prefixWidth'],
        postfixWidth = json['postfixWidth'],
        size = json['size'],
        category = json['category'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'laundryId': laundryId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'initialCharges': initialCharges,
      'charges': charges,
      'length': length,
      'prefixLength': prefixLength,
      'postfixLength': postfixLength,
      'width': width,
      'prefixWidth': prefixWidth,
      'postfixWidth': postfixWidth,
      'size': size,
      'category': category,
    };
  }

  Carpet copyWith({
    int? id,
    int? laundryId,
    String? name,
    String? image,
    int? quantity,
    double? initialCharges,
    double? charges,
    double? length,
    int? prefixLength,
    int? postfixLength,
    double? width,
    int? prefixWidth,
    int? postfixWidth,
    double? size,
    String? category,
  }) {
    return Carpet(
      id: id ?? this.id,
      laundryId: laundryId ?? this.laundryId,
      name: name ?? this.name,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      initialCharges: initialCharges ?? this.initialCharges,
      charges: charges ?? this.charges,
      length: length ?? this.length,
      prefixLength: prefixLength ?? this.prefixLength,
      postfixLength: postfixLength ?? this.postfixLength,
      width: width ?? this.width,
      prefixWidth: prefixWidth ?? this.prefixWidth,
      postfixWidth: postfixWidth ?? this.postfixWidth,
      size: size ?? this.size,
      category: category ?? this.category,
    );
  }
}
