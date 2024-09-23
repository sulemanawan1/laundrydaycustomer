import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'Help'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              20.ph,
              Container(
                decoration: BoxDecoration(
                    color: ColorManager.mediumWhiteColor,
                    borderRadius: BorderRadius.circular(AppSize.s8)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.support_agent),
                      title: const Text('Support'),
                      onTap: () {},
                    ),
                    10.ph,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: HeadingMedium(
                          title: 'Want to join as Agent?',
                          color: ColorManager.primaryColor,
                        )),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.verified_user),
                      title: const Text('Agent Registration'),
                      onTap: () {
                        GoRouter.of(context)
                            .pushReplacementNamed(RouteNames.agentRegistration);
                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.verified_user),
                      title: const Text('Service Provider'),
                      onTap: () {
                        GoRouter.of(context).pushNamed(RouteNames.addLaundry);
                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      leading: const Icon(Icons.warning),
                      title: const Text('Laundry Care Guide'),
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed(RouteNames.laundryCareGuide);
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
