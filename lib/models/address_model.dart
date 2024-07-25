// import 'package:flutter/widgets.dart';

// class AddressModel {
//   int? id;
//   double? lat;
//   double? long;
//   String? address;
//   String? name;
//   String? detail;
//   String? img;
//   AddressModel({
//     this.id,
//     this.lat,
//     this.long,
//     this.address,
//     this.name,
//     this.detail,
//     this.img,
//   });

//   AddressModel copyWith({
//     ValueGetter<int?>? id,
//     ValueGetter<double?>? lat,
//     ValueGetter<double?>? long,
//     ValueGetter<String?>? address,
//     ValueGetter<String?>? name,
//     String? detail,
//     ValueGetter<String?>? img,
//   }) {
//     return AddressModel(
//       id: id != null ? id() : this.id,
//       lat: lat != null ? lat() : this.lat,
//       long: long != null ? long() : this.long,
//       address: address != null ? address() : this.address,
//       name: name != null ? name() : this.name,
//       detail: detail ?? this.detail,
//       img: img != null ? img() : this.img,
//     );
//   }
// }
