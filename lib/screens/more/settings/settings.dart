import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/more/settings/settings_notifier.dart';
import 'package:laundryday/services/resources/colors.dart';
import 'package:laundryday/services/resources/sized_box.dart';
import 'package:laundryday/services/resources/value_manager.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/heading.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.ph,
          const Heading(title: 'Languages'),
          10.ph,
          Consumer(builder: (context, ref, child) {
            var lng = ref.watch(lanugaeProvider);

            return Expanded(
              child: ListView.separated(
                separatorBuilder: ((context, index) => 10.ph),
                itemCount: lng.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: lng[index].isSelected == true
                                  ? ColorManager.primaryColor
                                  : Colors.transparent)),
                      child: ListTile(
                        onTap: () {},
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.radio_button_checked,
                              color: lng[index].isSelected == true
                                  ? ColorManager.primaryColor
                                  : ColorManager.greyColor),
                        ),
                        title: Text(
                          lng[index].name.toString(),
                          style: getRegularStyle(
                              color: ColorManager.blackColor),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ]),
      ),
    );
  }
}
