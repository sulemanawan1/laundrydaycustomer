import 'package:go_router/go_router.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/add_new_card.dart/add_new_card.dart';
import 'package:laundryday/screens/auth/login/login.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/auth/verification/verification.dart';
import 'package:laundryday/screens/blankets_and_linen/blanket_and_linen_service_detail.dart';
import 'package:laundryday/screens/blankets_and_linen/blankets_category.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/delivery_pickup/components/view_image.dart';
import 'package:laundryday/screens/carpets/carpet_service_detail/carpet_service_detail.dart';
import 'package:laundryday/screens/laundry_care_guide/laundry_care_guide.dart';
import 'package:laundryday/screens/more/payment_options/payment_options.dart';
import 'package:laundryday/screens/order_review/order_review.dart';
import 'package:laundryday/screens/find_courier/find_courier.dart';
import 'package:laundryday/screens/invoice/invoice.dart';
import 'package:laundryday/screens/order_chat/order_chat.dart';
import 'package:laundryday/screens/order_checkout/order_checkout.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/order_summary/order_summary.dart';
import 'package:laundryday/screens/rate_courier/rate_courier.dart';
import 'package:laundryday/screens/splash/splash.dart';
import 'package:laundryday/screens/tax_invoice/tax_invoice.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/add_new_address.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/my_addresses.dart';
import 'package:laundryday/screens/more/help/agent_registration/agent_registration.dart';
import 'package:laundryday/screens/more/help/agent_registration/fetch_agent_address.dart';
import 'package:laundryday/screens/more/help/business_partner/view/business_partner.dart';
import 'package:laundryday/screens/more/profile/edit_profile/edit_profile.dart';
import 'package:laundryday/screens/more/help/help.dart';
import 'package:laundryday/screens/home/home.dart';
import 'package:laundryday/screens/more/more.dart';
import 'package:laundryday/screens/carpet_order_checkout/carpet_order_checkout.dart';
import 'package:laundryday/screens/more/profile/profile.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/screens/more/settings/settings.dart';
import 'package:laundryday/utils/routes/route_paths.dart';
import '../../screens/carpets/carpets_category/carpes_category.dart';

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
              builder: (context, state) => const Home()),
          GoRoute(
              name: RouteNames().signUp,
              path: "signup",
              builder: (context, state) => const Signup()),
          GoRoute(
              name: RouteNames().verification,
              path: "verification",
              builder: (context, state) => const Verification()),

          GoRoute(
            name: RouteNames().profile,
            path: "profile",
            builder: (context, state) => const Profile(),
          ),

          GoRoute(
              name: RouteNames().carpetsScreen,
              path: "carpets",
              builder: (context, state) => CarpetsCategory(
                  arguments: state.extra as CarpetDetailsArguments?)),
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
            builder: (context, state) => const Services(),
          ),
          GoRoute(
            name: RouteNames().serviceDetail,
            path: "service_detail",
            builder: (context, state) {
              return CarpetServiceDetail(
                  services: state.extra as ServicesModel?);
            },
          ),
          GoRoute(
            name: RouteNames().addNewAddress,
            path: "add_new_address",
            builder: (context, state) => const AddNewAddress(),
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
                  area: state.uri.queryParameters['area'].toString(),
                  city: state.uri.queryParameters['city'].toString(),
                );
              }),

          GoRoute(
            name: RouteNames().fetchAgentAddress,
            path: "fetch_agent_address",
            builder: (context, state) => const FetchAgentAddress(),
          ),

          GoRoute(
            name: RouteNames().carpetOrderCheckout,
            path: "carpet_order_checkout",
            builder: (context, state) => CarpetOrderCheckout(
                orderDatailsArguments: state.extra as CarpetDetailsArguments),
          ),

          GoRoute(
            name: RouteNames().orderReview,
            path: "cloth_order_review",
            builder: (context, state) => OrderReview(
                orderDatailsArguments: state.extra as Arguments),
          ),

          GoRoute(
            name: RouteNames().help,
            path: "help",
            builder: (context, state) => const Help(),
          ),

          GoRoute(
            name: RouteNames().businessPartner,
            path: "business_partner",
            builder: (context, state) => const BusinessPartner(),
          ),

          GoRoute(
            name: RouteNames().blanketAndLinenServiceDetail,
            path: "blanket_and_linen_service_detail",
            builder: (context, state) => BlanketAndLinenServiceDetail(
                services: state.extra as ServicesModel?),
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
            builder: (context, state) =>  FindCourier(orderDatailsArguments: state.extra as Arguments?,),
          ),

          GoRoute(
            name: RouteNames().orderProcess,
            path: "order_process",
            builder: (context, state) =>  OrderProcess(orderDatailsArguments: state.extra as Arguments? ,),
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
