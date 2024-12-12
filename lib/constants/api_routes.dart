class Api {
  static const String baseUrl = 'http://192.168.1.5:8000/api/';
  static const String imageUrl = 'http://192.168.1.5:8000/storage/';
  static const String googleBaseUrl = "maps.googleapis.com";

  static const String googleKey = "AIzaSyBWh1CNv4DHMHLSD-EVOrJYOFXefDNyKIw";
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
  static const String district = "${baseUrl}districts/district";

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
  static const String pickupOrderRoundTrip =
      "${baseUrl}orders/pickup-order-round-trip";
  static const String pickupRequestUpdate =
      "${baseUrl}orders/pickup-request-update";
  static const String paymentCollected = "${baseUrl}orders/payment-collected";

  static const String order = "${baseUrl}orders/detail?id=";

  static const String customerOrders = "${baseUrl}orders/customer?user_id=";
  static const String pendingPickupRequests =
      "${baseUrl}orders/pending-pickup-requests/?user_id=";

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
  static const String subscriptionPlans = "${baseUrl}subscription_plans/type";

  static const String createUserSubscriptions =
      "${baseUrl}user_subscriptions/create";
  static const String updateBranch =
      "${baseUrl}user_subscriptions/update/branch";
  static const String activeUserSubscription =
      "${baseUrl}user_subscriptions/active/";
  static const String cancelUserSubscription =
      "${baseUrl}user_subscriptions/cancel/";
  static const String walletBalance =
      "${baseUrl}wallet/";
  static const String calculate = "${baseUrl}orders/calculate";
  static const String validAllcoupons = "${baseUrl}coupons/valid-all";



      
}
