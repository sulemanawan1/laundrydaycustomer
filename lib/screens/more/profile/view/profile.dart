import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/screens/more/profile/provider/profile_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_loader.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    return Scaffold(
        appBar: MyAppBar(
          title: "Profile",
        ),
        body: userProfile.when(
            data: (data) {
              return data.fold((l) => Text(l.toString()), (r) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Heading(title: 'Personal Information'),
                      10.ph,
                      Text(
                        'Profile Picture',
                        style: getMediumStyle(
                            color: ColorManager.blackColor,
                            fontSize: FontSize.s14),
                      ),
                      10.ph,
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.lightGrey),
                          image: r.user!.image == null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AssetImages.user))
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      Api.imageUrl + r.user!.image.toString())),
                          color: ColorManager.mediumWhiteColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      10.ph,
                      const Divider(),
                      10.ph,
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(RouteNames.editProfile, extra: r);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        title: Text('Full Name'),
                        leading: Icon(
                          Icons.person_2,
                          color: ColorManager.greyColor,
                        ),
                        subtitle: Text(
                          "${r.user!.firstName!.toString()}",
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                RouteNames.changeMobileNumber,
                                extra: r);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        title: Text('Mobile Number'),
                        leading: Icon(Icons.phone_android),
                        subtitle: Text("${r.user!.mobileNumber!.toString()}"),
                      ),
                      const Divider(),
                      const Spacer(),
                      40.ph,
                    ],
                  ),
                );
              });
            },
            error: (e, s) => Text(e.toString()),
            loading: () => Loader()));
  }
}
