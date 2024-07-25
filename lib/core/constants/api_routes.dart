class Api {
  static const String baseUrl = 'http://192.168.1.3:8000/api/';
  static const String imageUrl = 'http://192.168.1.3:8000/storage/';
  static const String googleKey = "AIzaSyADOyZQM-g74gad7B-kU4OtuX5cMsJm79M";
  //Auth
  static const String checkUserByMobileNumber =
      "${baseUrl}check-user-by-mobile-number";
  static const String registerCustomer = "${baseUrl}registerCustomer";
  // Services
  static const String allService = "${baseUrl}allService";

  //Addresses
  static const String addAddress = "${baseUrl}addresses/add";
  static const String updateAddress = "${baseUrl}addresses/update";

  static const String allAddresses = "${baseUrl}addresses/all/";
  static const String deleteAddress = "${baseUrl}addresses/delete/";

  //Countries
  static const String countries = "${baseUrl}countries";

  //Regions
  static const String regions = "${baseUrl}regions";

  //Cities
  static const String cities = "${baseUrl}cities";

  //Districts
  static const String districts = "${baseUrl}districts";

  //Branches

  static const String registerBranch = "${baseUrl}branches/register";
  static const String registerLaundry = "${baseUrl}laundries/register";

  //Laundries
  static const String nearstBranch = "${baseUrl}branches/nearest";
  static const String branchByArea = "${baseUrl}branches/branches-by-area";

  // Categories

  static const String categoriesWithItems = "${baseUrl}categories-with-items/";

  //ServiceTimings

    static const String serviceTimings = "${baseUrl}service-timings/";


//Item Variations

  static const String itemVariations = "${baseUrl}item_variations/?";

}
