import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';

import '../../../../Widgets/my_heading/heading.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({super.key});

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'My Addresses'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Heading(text: "My addresses"),
          10.ph,
           MyButton(onPressed: (){

                    GoRouter.of(context).pushNamed(RouteNames().addNewAddress);

           },isBorderButton: true,name: 'Add Address',),
          10.ph,
          Expanded(
            child: ListView.separated(
              separatorBuilder: ((context, index) => 10.ph),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorManager.primaryColor)),
                  child: ListTile(
                    isThreeLine: false,
                    
                    leading:  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Icons.radio_button_checked,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    title: Text(
                      "Riyadh",
                      style: GoogleFonts.poppins(color: ColorManager. blackColor),
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      "Al Hazm- Riyadh",
                      style: GoogleFonts.poppins(color: ColorManager.greyColor),
                      maxLines: 1,
                    ),
                    trailing: Wrap(children: [
                      IconButton(
                          onPressed: () {},
                          icon:  Icon(Icons.edit,color: ColorManager. primaryColor,)),
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
          MyButton(
            name: "Select",
            onPressed: () {

              // openMaps(24.746394, 46.681293);
            },
          ),
          30.ph
        ]),
      ),
    );
  }

  
}

