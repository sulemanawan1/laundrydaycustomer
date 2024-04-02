import 'dart:convert';


class ItemModel {
  int? id;
  int? laundryId;
  String? name;
  String? image;
  int? quantity;
  double? initialCharges;
  double? charges;
  String? category;
  int? categoryId;
  int? blanketItemId;
  int? serviceId;
  
//Carpet 
  double? length;
  double? width;
  int? prefixLength;
  int? postfixLength;
  int? prefixWidth;
  int? postfixWidth;
  double? size;


  ItemModel({
    this.id,
    this.laundryId,
    this.name,
    this.image,
    this.quantity,
    this.initialCharges,
    this.charges,
    this.category,
    this.categoryId,
    this.blanketItemId,
    this.serviceId,
    this.length,
    this.width,
    this.prefixLength,
    this.postfixLength,
    this.prefixWidth,
    this.postfixWidth,
    this.size,
  });
  


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'laundryId': laundryId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'initialCharges': initialCharges,
      'charges': charges,
      'category': category,
      'categoryId': categoryId,
      'blanketItemId': blanketItemId,
      'serviceId': serviceId,
      'length': length,
      'width': width,
      'prefixLength': prefixLength,
      'postfixLength': postfixLength,
      'prefixWidth': prefixWidth,
      'postfixWidth': postfixWidth,
      'size': size,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt(),
      laundryId: map['laundryId']?.toInt(),
      name: map['name'],
      image: map['image'],
      quantity: map['quantity']?.toInt(),
      initialCharges: map['initialCharges']?.toDouble(),
      charges: map['charges']?.toDouble(),
      category: map['category'],
      categoryId: map['categoryId']?.toInt(),
      blanketItemId: map['blanketItemId']?.toInt(),
      serviceId: map['serviceId']?.toInt(),
      length: map['length']?.toDouble(),
      width: map['width']?.toDouble(),
      prefixLength: map['prefixLength']?.toInt(),
      postfixLength: map['postfixLength']?.toInt(),
      prefixWidth: map['prefixWidth']?.toInt(),
      postfixWidth: map['postfixWidth']?.toInt(),
      size: map['size']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));
}

// class Carpets extends ItemModel {
//   double? length;
//   double? width;
//   int? prefixLength;
//   int? postfixLength;
//   int? prefixWidth;
//   int? postfixWidth;
//   double? size;

//   Carpets({
//     int? id,
//     int? laundryId,
//     String? name,
//     String? image,
//     int? quantity,
//     double? initialCharges,
//     double? charges,
//     String? category,
//     int? categoryId,
//     int? blanketItemId,
//     final int? serviceId,
//     this.length,
//     this.width,
//     this.prefixLength,
//     this.postfixLength,
//     this.prefixWidth,
//     this.postfixWidth,
//     this.size,
//   }) : super(
//             id: id,
//             name: name,
//             laundryId: laundryId,
//             quantity: quantity,
//             image: image,
//             charges: charges,
//             initialCharges: initialCharges,
//             categoryId: categoryId,
//             blanketItemId: blanketItemId,
//             serviceId: serviceId);

 

  

//   Map<String, dynamic> toMap() {
//     return {
//       'length': length,
//       'width': width,
//       'prefixLength': prefixLength,
//       'postfixLength': postfixLength,
//       'prefixWidth': prefixWidth,
//       'postfixWidth': postfixWidth,
//       'size': size,
//     };
//   }

//   factory Carpets.fromMap(Map<String, dynamic> map) {
//     return Carpets(
//       length: map['length']?.toDouble(),
//       width: map['width']?.toDouble(),
//       prefixLength: map['prefixLength']?.toInt(),
//       postfixLength: map['postfixLength']?.toInt(),
//       prefixWidth: map['prefixWidth']?.toInt(),
//       postfixWidth: map['postfixWidth']?.toInt(),
//       size: map['size']?.toDouble(),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Carpets.fromJson(String source) => Carpets.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Carpets(length: $length, width: $width, prefixLength: $prefixLength, postfixLength: $postfixLength, prefixWidth: $prefixWidth, postfixWidth: $postfixWidth, size: $size)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is Carpets &&
//       other.length == length &&
//       other.width == width &&
//       other.prefixLength == prefixLength &&
//       other.postfixLength == postfixLength &&
//       other.prefixWidth == prefixWidth &&
//       other.postfixWidth == postfixWidth &&
//       other.size == size;
//   }

//   @override
//   int get hashCode {
//     return length.hashCode ^
//       width.hashCode ^
//       prefixLength.hashCode ^
//       postfixLength.hashCode ^
//       prefixWidth.hashCode ^
//       postfixWidth.hashCode ^
//       size.hashCode;
//   }
// }
