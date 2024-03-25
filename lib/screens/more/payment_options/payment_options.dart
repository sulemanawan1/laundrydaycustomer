import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBar(title: 'Payment Options',),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      10.ph,
      const Heading(text: 'My Cards'),
      20.ph,
      ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Card(color: ColorManager.whiteColor,
            child: ListTile(leading: Image.asset('assets/visa.png',height: 20,),
            title: Text('Suleman Abrar'),
            subtitle: Text('Ending with ${3886}'),
            
            
            
            
            ),
          ) ;
        },
      ),
      

      MyButton(
              isBorderButton: true,
              widget: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.add_circle_outline),
                  5.pw,
                  Text(
                    'Add New Debit/Credit',
                    style: GoogleFonts.poppins(
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )),
              name: '',
              onPressed: () {
                context.pushNamed(RouteNames().addNewCard);
              },
            )
      
      
      
      ],),
    ),

    
    
    
    );
  }
}