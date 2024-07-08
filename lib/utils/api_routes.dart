class Api {
  static const String baseUrl = 'http://192.168.1.2:8000/api/';
  static const String imageUrl = 'http://192.168.1.2:8000/storage/';

//Auth
  static const String checkUserByMobileNumber =
      "${baseUrl}check-user-by-mobile-number";
  static const String registerCustomer = "${baseUrl}registerCustomer";
  // Services
  static const String allService = "${baseUrl}allService";

  //Addresses
  static const String addAddress = "${baseUrl}addresses/add";
    static const String allAddresses = "${baseUrl}addresses/all/";

}
