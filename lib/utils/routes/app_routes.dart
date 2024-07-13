import 'package:go_router/go_router.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/screens/add_laundry/view/add_laundry.dart';
import 'package:laundryday/screens/add_new_card.dart/add_new_card.dart';
import 'package:laundryday/screens/auth/login/view/login.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/auth/verification/view/verification.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/view/update_address.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/screens/laundry_items/view/laundry_items.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/delivery_pickup/components/view_image.dart';
import 'package:laundryday/screens/laundry_care_guide/laundry_care_guide.dart';
import 'package:laundryday/screens/more/payment_options/payment_options.dart';
import 'package:laundryday/screens/order_review/order_review.dart';
import 'package:laundryday/screens/find_courier/view/find_courier.dart';
import 'package:laundryday/screens/invoice/invoice.dart';
import 'package:laundryday/screens/order_chat/view/order_chat.dart';
import 'package:laundryday/screens/order_checkout/order_checkout.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/order_summary/order_summary.dart';
import 'package:laundryday/screens/rate_courier/rate_courier.dart';
import 'package:laundryday/screens/splash/splash.dart';
import 'package:laundryday/screens/tax_invoice/view/tax_invoice.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/view/add_new_address.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/my_addresses.dart';
import 'package:laundryday/screens/more/help/agent_registration/view/agent_registration.dart';
import 'package:laundryday/screens/more/profile/edit_profile/edit_profile.dart';
import 'package:laundryday/screens/more/help/help.dart';
import 'package:laundryday/screens/home/home.dart';
import 'package:laundryday/screens/more/more.dart';
import 'package:laundryday/screens/more/profile/profile.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/screens/more/settings/settings.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressesmodel;

class AppRoutes {
  final GoRouter routes = GoRouter(routes: [
    GoRoute(
        name: RouteNames().splash,
        path: "/",
        builder: (context, state) => const Splash(),
        routes: [
          //  GoRoute(
          //     name: RouteNames().login,
          //     path: RoutePaths().login,
          //     builder: (context, state) => Login()),
          GoRoute(
              name: RouteNames().login,
              path: 'login',
              builder: (context, state) => Login()),
          GoRoute(
              name: RouteNames().home,
              path: 'home',
              builder: (context, state) => Home()),
          GoRoute(
              name: RouteNames().signUp,
              path: "signup",
              builder: (context, state) => SignUp(
                    mobileNumber: state.extra as String,
                  )),
          GoRoute(
              name: RouteNames().verification,
              path: "verification",
              builder: (context, state) => Verification(
                    verificationId: state.extra as String,
                  )),

          GoRoute(
            name: RouteNames().profile,
            path: "profile",
            builder: (context, state) => const Profile(),
          ),

          GoRoute(
            name: RouteNames().furnitureScreen,
            path: "furniture",
            builder: (context, state) => const MyAddresses(),
          ),
          GoRoute(
            name: RouteNames().more,
            path: "more",
            builder: (context, state) => const More(),
          ),

          GoRoute(
            name: RouteNames().services,
            path: "services",
            builder: (context, state) => Services(),
          ),

          GoRoute(
            name: RouteNames().addNewAddress,
            path: "add_new_address",
            builder: (context, state) => AddNewAddress(),
          ),
          GoRoute(
            name: RouteNames().updateAddress,
            path: "update_address",
            builder: (context, state) =>
                UpdateAddress(address: state.extra as myaddressesmodel.Address),
          ),
          GoRoute(
            name: RouteNames().myAddresses,
            path: "my_addresses",
            builder: (context, state) => const MyAddresses(),
          ),

          GoRoute(
            name: RouteNames().settings,
            path: "settings",
            builder: (context, state) => const Settings(),
          ),

          GoRoute(
            name: RouteNames().editProfile,
            path: "edit_profile",
            builder: (context, state) => const EditProfile(),
          ),

          GoRoute(
              name: RouteNames().agentRegistration,
              path: "agent_registration",
              builder: (context, state) {
                return AgentRegistration(
                  
                );
              }),

          

          GoRoute(
            name: RouteNames().orderReview,
            path: "order_review",
            builder: (context, state) =>
                OrderReview(orderDatailsArguments: state.extra as Arguments),
          ),

          GoRoute(
            name: RouteNames().help,
            path: "help",
            builder: (context, state) => const Help(),
          ),

          GoRoute(
            name: RouteNames().addLaundry,
            path: "add_laundry",
            builder: (context, state) => const AddLaundry(),
          ),

          GoRoute(
            name: RouteNames().laundries,
            path: "blanket_and_linen_service_detail",
            builder: (context, state) =>
                Laundries(services: state.extra as s.Datum?),
          ),

          GoRoute(
            name: RouteNames().blanketsCategory,
            path: "blankets_category",
            builder: (context, state) => BlanketsCategory(
              laundry: state.extra as LaundryModel?,
            ),
          ),
          GoRoute(
              name: RouteNames().deliveryPickup,
              path: "delivery_pickup",
              builder: (context, state) =>
                  DeliveryPickup(arguments: state.extra as Arguments?)),

          GoRoute(
            name: RouteNames().orderSummary,
            path: "order_summary",
            builder: (context, state) => const OrderSummary(),
          ),

          GoRoute(
            name: RouteNames().orderChat,
            path: "order_chat",
            builder: (context, state) => const OrderChat(),
          ),

          GoRoute(
            name: RouteNames().findCourier,
            path: "find_courier",
            builder: (context, state) => FindCourier(
              orderDatailsArguments: state.extra as Arguments?,
            ),
          ),

          GoRoute(
            name: RouteNames().orderProcess,
            path: "order_process",
            builder: (context, state) => OrderProcess(
              orderDatailsArguments: state.extra as Arguments?,
            ),
          ),

          GoRoute(
            name: RouteNames().orderCheckout,
            path: "order_checkout",
            builder: (context, state) => const OrderCheckout(),
          ),

          GoRoute(
            name: RouteNames().invoice,
            path: "invoice",
            builder: (context, state) => const Invoice(),
          ),

          GoRoute(
            name: RouteNames().taxInvoice,
            path: "tax_invoice",
            builder: (context, state) => const TaxInvoice(),
          ),

          GoRoute(
            name: RouteNames().rateCourier,
            path: "rate_courier",
            builder: (context, state) => const RateCourier(),
          ),
          GoRoute(
            name: RouteNames().addNewCard,
            path: "add_new_card",
            builder: (context, state) => AddNewCard(),
          ),
          GoRoute(
            name: RouteNames().viewImage,
            path: "view_image",
            builder: (context, state) => ViewImage(
              image: state.extra as String?,
            ),
          ),

          GoRoute(
            name: RouteNames().laundryCareGuide,
            path: "laundry_care_guide",
            builder: (context, state) => LaundryCareGuilde(),
          ),

          GoRoute(
            name: RouteNames().paymentOptions,
            path: "payment_options",
            builder: (context, state) => PaymentOptions(),
          )
        ]),
  ]);
}
