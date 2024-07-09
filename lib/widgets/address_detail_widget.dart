import 'package:flutter/material.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/constants/sized_box.dart';

class AddressDetailWidget extends StatelessWidget {
  const AddressDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(children: [
          10.ph,
          Row(
            children: [
              const Icon(
                Icons.flag,
                size: 14,
              ),
              10.pw,
               HeadingMedium(title: 'Pickup From'),
              4.pw,
              const Text('Al Mashtal ,Riyadh')
            ],
          ),
          10.ph,
          Row(
            children: [
              const Icon(Icons.inventory, size: 14),
              10.pw,
               HeadingMedium(title: 'Delivered To'),
              4.pw,
              const Expanded(
                  child: Text(
                'Al Mahamid,AlHazm ,Riyadh',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
          10.ph,
        ]),
      ),
    );
  }
}
