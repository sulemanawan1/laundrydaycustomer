import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_notifier.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';

class MyAddresses extends ConsumerWidget {
  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myAddresesProvider).addressModel;

    return Scaffold(
      appBar: MyAppBar(title: 'My Addresses'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Heading(text: "My addresses"),
              data == null
                  ? SizedBox()
                  : (data.addresses!.length == 0)
                      ? SizedBox()
                      : TextButton.icon(
                          style: ButtonStyle(
                            iconColor: WidgetStateColor.resolveWith(
                              (Set<WidgetState> states) {
                                return ColorManager
                                    .primaryColor; // Cor quando focado
                                // Cor padrão
                              },
                            ),
                          ),
                          label: Text(
                            'Add Address',
                            style: GoogleFonts.poppins(
                                color: ColorManager.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeightManager.semiBold),
                          ),
                          icon: Icon(Icons.add_location),
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(RouteNames().addNewAddress);
                          },
                        ),
            ],
          ),
          10.ph,
          data == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: ColorManager.primaryColor,
                ))
              : (data.addresses!.length == 0)
                  ? Expanded(
                      child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(height: 100, 'assets/my_addresses.png'),
                            10.ph,
                            Text(
                              textAlign: TextAlign.center,
                              data.message.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ))
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: ((context, index) => 10.ph),
                        itemCount: data.addresses!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: ColorManager.primaryColor)),
                            child: ListTile(
                              isThreeLine: false,
                              leading: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(
                                  Icons.radio_button_checked,
                                  color: ColorManager.primaryColor,
                                ),
                              ),
                              title: Text(
                                data.addresses![index].addressName.toString(),
                                style: GoogleFonts.poppins(
                                    color: ColorManager.blackColor),
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                data.addresses![index].addressDetail.toString(),
                                style: GoogleFonts.poppins(
                                    color: ColorManager.greyColor),
                                maxLines: 1,
                              ),
                              trailing: Wrap(children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: ColorManager.primaryColor,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
          10.ph,
          data == null
              ? SizedBox()
              : (data.addresses!.length == 0)
                  ? MyButton(
                      name: "Add Address",
                      onPressed: () {
                        GoRouter.of(context)
                            .pushNamed(RouteNames().addNewAddress);
                      },
                    )
                  : MyButton(
                      name: 'Select',
                      onPressed: () {},
                    ),
          30.ph
        ]),
      ),
    );
  }
}
