import 'package:flutter/material.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/widgets/heading.dart';

class OrderItemWidget extends StatelessWidget {
  final List<ItemModel> items;
  const OrderItemWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.ph,
            const Heading(title: 'Order Details'),
            5.ph,
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              child: Card(
                elevation: 0,
                child: ListView.separated(
                  separatorBuilder: (context, index) => 5.ph,
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(items[index].name.toString()),
                          ),
                          Expanded(
                            child: Text("x${items[index].quantity.toString()}"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
