import 'dart:io';
import 'package:flutter/material.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';

class TaxInvoice extends StatefulWidget {
  const TaxInvoice({super.key});

  @override
  State<TaxInvoice> createState() => _TaxInvoiceState();
}

class _TaxInvoiceState extends State<TaxInvoice> {
  File? myFIle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Tax Invoice',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tax Bill',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              8.ph,
              const Text(
                'شركة اختصار الزمن لنقل الطرود مساهمة مقفلة',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              8.ph,
              const Text(
                'Building No 3273 Anas Bin Malek AlSahafah Dist, Riyadh, KSA',
                style: TextStyle(fontSize: 10),
              ),
              8.ph,
              const InvoiceTextWidget(
                title: 'تاريخ الفاتورة\nInvoice Date',
                text: '2024-02-13 05:47:03',
              ),
              const InvoiceTextWidget(
                title: 'الرقم التعريفي الضريبي\nTax Identification Number',
                text: '311024805300003',
              ),
              const InvoiceTextWidget(
                title: 'رقم الفاتورة / رقم الطلب\nInvoice Number Order /Number',
                text: '6989403',
              ),
              const InvoiceTextWidget(
                title: 'تفاصيل الفاتورة\nInvoice Details',
                text: '',
              ),
              const InvoiceTextWidget(
                title: 'رسوم التوصيل\nDelivery Fees',
                text: '14 SAR',
              ),
              const InvoiceTextWidget(
                title: 'رسوم الخدمة\nService Fees',
                text: '2.00 SAR',
              ),
              const InvoiceTextWidget(
                title: 'الاجمالي شامل الضريبة\nSub Total VAT Inclusive',
                text: '18.4 SAR',
              ),
              8.ph,
               Divider(
                color: ColorManager. blackColor,
              ),
          
              const InvoiceTextWidget(
                title: 'معدل ضريبة القيمةالمضافة\n VAT',
                text: '15.00',
              ),
              const InvoiceTextWidget(
                title:
                    'اجمالي ضريبة القيمة المضافة التي تم جمعها\nTotal VAT Collected',
                text: '2.40 SAR',
              ),
          Image.asset('assets/qr.jpg',height: 100,)
          
          
            ],
          ),
        ),
      ),
    );
  }

}

class InvoiceTextWidget extends StatelessWidget {
  final String? title;
  final String? text;

  const InvoiceTextWidget({super.key, required this.text, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textAlign: TextAlign.right,
              text!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              textAlign: TextAlign.right,
              title!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        15.ph,
      ],
    );
  }
}




