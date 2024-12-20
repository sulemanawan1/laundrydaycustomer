import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/models/order_list_model.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/screens/add_new_card.dart/add_new_card.dart';
import 'package:laundryday/screens/auth/login/view/login.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/auth/verification/view/verification.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/view/update_address.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/screens/laundry_items/view/laundry_items.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/delivery_pickup/components/view_image.dart';
import 'package:laundryday/screens/laundry_care_guide/laundry_care_guide.dart';
import 'package:laundryday/screens/more/payment_options/payment_options.dart';
import 'package:laundryday/screens/more/profile/view/change_mobile_number.dart';
import 'package:laundryday/screens/more/profile/view/change_mobile_number_verification.dart';
import 'package:laundryday/screens/more/wallet/view/wallet.dart';
import 'package:laundryday/screens/order_review/presentaion/page/order_review.dart';
import 'package:laundryday/screens/order_chat/view/order_chat.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/pending_pickup_requests/view/pending_pickup_requests.dart';
import 'package:laundryday/screens/rating_and_review/rating_and_review.dart';
import 'package:laundryday/screens/splash/splash.dart';
import 'package:laundryday/screens/subscription/view/subscription.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_states.dart';
import 'package:laundryday/screens/subscription_laundry/view/subscription_laundry.dart';
import 'package:laundryday/screens/tax_invoice/view/tax_invoice.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/view/add_new_address.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/my_addresses.dart';
import 'package:laundryday/screens/more/help/agent_registration/view/agent_registration.dart';
import 'package:laundryday/screens/more/profile/view/edit_profile.dart';
import 'package:laundryday/screens/more/help/help.dart';
import 'package:laundryday/screens/home/home.dart';
import 'package:laundryday/screens/more/more.dart';
import 'package:laundryday/screens/more/profile/view/profile.dart' as profile;
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/screens/more/settings/settings.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressesmodel;

final goRouterProvider = Provider<GoRouter>((ref) => GoRouter(
    observers: [BotToastNavigatorObserver()], //2. registered route observer

    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.splash,
        path: "/",
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
          name: RouteNames.login,
          path: '/login',
          builder: (context, state) => Login()),
      GoRoute(
          name: RouteNames.home,
          path: '/home',
          builder: (context, state) => Home()),
      GoRoute(
          name: RouteNames.signUp,
          path: "/signup",
          builder: (context, state) => SignUp(
                mobileNumber: state.extra as String,
              )),
      GoRoute(
          name: RouteNames.verification,
          path: "/verification",
          builder: (context, state) => Verification(
                verificationId: state.extra as String,
              )),
      GoRoute(
        name: RouteNames.profile,
        path: "/profile",
        builder: (context, state) => profile.Profile(),
      ),
      GoRoute(
        name: RouteNames.more,
        path: "/more",
        builder: (context, state) => const More(),
      ),
      GoRoute(
        name: RouteNames.services,
        path: "/services",
        builder: (context, state) => Services(),
      ),
      GoRoute(
        name: RouteNames.addNewAddress,
        path: "/add_new_address",
        builder: (context, state) => AddNewAddress(),
      ),
      GoRoute(
        name: RouteNames.updateAddress,
        path: "/update_address",
        builder: (context, state) =>
            UpdateAddress(address: state.extra as myaddressesmodel.Address),
      ),
      GoRoute(
        name: RouteNames.myAddresses,
        path: "/my_addresses",
        builder: (context, state) => const MyAddresses(),
      ),
      GoRoute(
        name: RouteNames.settings,
        path: "/settings",
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        name: RouteNames.editProfile,
        path: "/edit_profile",
        builder: (context, state) =>
            EditProfile(userModel: state.extra as UserModel),
      ),
      GoRoute(
          name: RouteNames.agentRegistration,
          path: "/agent_registration",
          builder: (context, state) {
            return AgentRegistration();
          }),
      GoRoute(
          name: RouteNames.orderReview,
          path: "/order_review",
          builder: (context, state) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;

            return OrderReview(
              orderType: args['order_type'],
            );
          }),
      GoRoute(
        name: RouteNames.help,
        path: "/help",
        builder: (context, state) => const Help(),
      ),
      GoRoute(
        name: RouteNames.laundries,
        path: "/laundries",
        builder: (context, state) => Laundries(),
      ),
      GoRoute(
        name: RouteNames.laundryItems,
        path: "/laundry_items",
        builder: (context, state) => LaundryItems(),
      ),
      GoRoute(
          name: RouteNames.deliveryPickup,
          path: "/delivery_pickup",
          builder: (context, state) {
            return DeliveryPickup(distanceDataModel: state.extra as DistanceDataModel,);
          }),
      GoRoute(
        name: RouteNames.orderChat,
        path: "/order_chat",
        builder: (context, state) => OrderChat(),
      ),
      GoRoute(
        name: RouteNames.orderProcess,
        path: "/order_process",
        builder: (context, state) => OrderProcess(
          orderId: state.extra as int,
        ),
      ),
      GoRoute(
        name: RouteNames.taxInvoice,
        path: "/tax_invoice",
        builder: (context, state) => const TaxInvoice(),
      ),
      GoRoute(
        name: RouteNames.ratingAndReview,
        path: "/rating_and_reviews",
        builder: (context, state) => const RatingAndReview(),
      ),
      GoRoute(
        name: RouteNames.addNewCard,
        path: "/add_new_card",
        builder: (context, state) => AddNewCard(),
      ),
      GoRoute(
        name: RouteNames.viewImage,
        path: "/view_image",
        builder: (context, state) => ViewImage(
          image: state.extra as String?,
        ),
      ),
      GoRoute(
        name: RouteNames.viewNetworkImage,
        path: "/view_network_image",
        builder: (context, state) => ViewNetworkImage(
          image: state.extra as String?,
        ),
      ),
      GoRoute(
        name: RouteNames.laundryCareGuide,
        path: "/laundry_care_guide",
        builder: (context, state) => LaundryCareGuilde(),
      ),
      GoRoute(
        name: RouteNames.paymentOptions,
        path: "/payment_options",
        builder: (context, state) => PaymentOptions(),
      ),
      GoRoute(
        name: RouteNames.changeMobileNumber,
        path: "/change_mobile_number",
        builder: (context, state) => ChangeMobileNumber(
          userModel: state.extra as UserModel,
        ),
      ),
      GoRoute(
        name: RouteNames.changeMobileNumberVerification,
        path: "/change_mobile_number_verfication",
        builder: (context, state) => ChangeMobileNumberVerification(
          verificationId: state.extra as String,
        ),
      ),
      GoRoute(
        name: RouteNames.subscriptionLaundry,
        path: "/subscription_laundry",
        builder: (context, state) => SubscriptionLaundry(
          screenType: state.extra as SubscriptionLaundryScreenType,
        ),
      ),
      GoRoute(
        name: RouteNames.subscription,
        path: "/subscription",
        builder: (context, state) => Subscription(),
      ),
      GoRoute(
        name: RouteNames.pendingPickupRequests,
        path: "/pending_pickup_requests",
        builder: (context, state) => PendingPickupRequests(
          orderListModel: state.extra as OrderListModel,
        ),
      ),
      GoRoute(
        name: RouteNames.wallet,
        path: "/wallet",
        builder: (context, state) => Wallet(),
      ),
    ]));
