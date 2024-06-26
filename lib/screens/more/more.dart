import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "More",
          isLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Heading(text: ' My Account'),
              20.ph,
              Container(
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                      context.pushNamed(RouteNames().profile);
                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.location_on),
                      title: const Text('Addresses'),
                      onTap: () {
                        // Navigate to the home screen
                        GoRouter.of(context)
                            .pushNamed(RouteNames().myAddresses);
                      },
                    ),

                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.credit_card),
                      title: const Text('Payment Options'),
                      onTap: () {
                        // Navigate to the home screen
                        GoRouter.of(context)
                            .pushNamed(RouteNames().paymentOptions);
                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.language),
                      title: const Text('Settings'),
                      onTap: () {
                        GoRouter.of(context).pushNamed(RouteNames().settings);
                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.help),
                      title: const Text('Help'),
                      onTap: () {
                      GoRouter.of(context).pushNamed(RouteNames().help);

                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        // Navigate to the about screen
                        GoRouter.of(context)
                            .pushNamed(RouteNames().login);
                      },
                    ),
                    
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
