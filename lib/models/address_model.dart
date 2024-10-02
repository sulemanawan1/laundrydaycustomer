class AddressModel {
  final String country;
  final String city;
  final String district;

  AddressModel(
      {required this.country, required this.city, required this.district});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    String country = '';
    String city = '';
    String district = '';

    for (var component in json['results'][0]['address_components']) {
      if (component['types'].contains('country')) {
        country = component['long_name'];
      }
      if (component['types'].contains('locality')) {
        city = component['long_name'];
      }

      if (component['types'].contains('sublocality')) {
        district = component['long_name'];

        if (district.isEmpty) {
          if (component['types'].contains('sublocality_level_1')) {
            district = component['long_name'];
          }
        }
      }
    }

    return AddressModel(
      country: country,
      city: city,
      district: district,
    );
  }
}
