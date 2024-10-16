class Api {
  static const String baseUrl = 'http://192.168.1.3:8000/api/';
  static const String imageUrl = 'http://192.168.1.3:8000/storage/';
  static const String googleBaseUrl = "maps.gomaps.pro";

  static const String googleKey = "AlzaSyR1nIdGY-BJhcLkX4MznrQkHs10ljL0mag";
  //Auth
  static const String checkUserByMobileNumber =
      "${baseUrl}check-user-by-mobile-number";
  static const String registerUser = "${baseUrl}register-user";
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

  static const String pickupOrder = "${baseUrl}orders/pickup-order";

  static const String roundTripOrder = "${baseUrl}orders/round-trip";
  static const String paymentCollected = "${baseUrl}orders/payment-collected";

  static const String order = "${baseUrl}orders/detail?id=";
  static const String customerOrders = "${baseUrl}orders/customer?user_id=";
  static const String storeFcmToken = "${baseUrl}device_tokens/store-fcm-token";
  static const String fcmTokens = "${baseUrl}device_tokens/fcm-tokens";
  static const String itemVariationSizes =
      "${baseUrl}item_variation_sizes/size?item_variation_id=";

  static const String nearByAgents = "${baseUrl}delivery_agents/near-by-agents";
  static const String registerDeliveryAgents =
      "${baseUrl}delivery_agents/register";

  static const String fetchUser = "${baseUrl}users/";
  static const String updateUser = "${baseUrl}users/update";
  static const String updateUserMobileNumber =
      "${baseUrl}users/update-mobile-number";
}
