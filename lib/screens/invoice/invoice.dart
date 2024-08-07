import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/routes/route_names.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';

class Invoice extends StatelessWidget {
  const Invoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Invoice',
          actions: [
            InkWell(
              onTap: () {
                context.pushNamed(RouteNames().taxInvoice);
              },
              child: Row(
                children: [
                  const Icon(Icons.receipt),
                  5.pw,
                  Text(
                    'Tax\nInvoice',
                    style:
                        GoogleFonts.poppins(color: ColorManager.primaryColor),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            10.pw,
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Image.asset(
                        'assets/invoice.png',
                      ))),
              20.ph,
              Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Image.asset(
                        'assets/pickup_invoice.jpeg',
                      ))),
            ],
          ),
        ));
  }
}
