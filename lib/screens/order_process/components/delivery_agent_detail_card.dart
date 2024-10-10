import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/models/chat_profile_model.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/my_user_model.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart'
    as ordermodel;
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils.dart';

class DeliveryAgentCard extends StatelessWidget {
  final WidgetRef ref;
  final ordermodel.OrderDeliveries orderDeliveries;
  final UserModel userModel;
  DeliveryAgentCard({
    super.key,
    required this.ref,
    required this.orderDeliveries,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                22.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          14.pw,
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AssetImages.user)),
                                color: ColorManager.nprimaryColor,
                                shape: BoxShape.circle),
                          ),
                          14.pw,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${orderDeliveries.user?.firstName}${orderDeliveries.user?.lastName}",
                                style: getRegularStyle(
                                    color: Color(0xFF242E42),
                                    fontSize: FontSize.s17),
                              ),
                              7.ph,
                              Row(
                                children: [
                                  Image.asset(width: 16, AssetImages.rating),
                                  5.pw,
                                  Text(
                                    "4.2",
                                    style: getRegularStyle(
                                        color: Color(0xFFC8C7CC),
                                        fontSize: FontSize.s15),
                                  ),
                                ],
                              ),
                              10.ph,
                              Text("Delivery Agent",
                                  style: getMediumStyle(
                                      color: Color(0xFF242E42),
                                      fontSize: FontSize.s14)),
                              10.ph,
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () async {
                                String? chatroomId = await createChatRoom(
                                    userModel, orderDeliveries);

                                if (chatroomId != null) {
                                  ChatProfileModel chatProfileModel =
                                      ChatProfileModel(
                                          receiverId: orderDeliveries.user!.id!,
                                          chatRoomId: chatroomId,
                                          firstName:
                                              orderDeliveries.user!.firstName!,
                                          lastName:
                                              orderDeliveries.user!.lastName!,
                                          image: orderDeliveries.user!.image);

                                  ref
                                      .read(orderProcessProvider.notifier)
                                      .selectChatProfile(
                                          chatProfileModel: chatProfileModel);

                                  context.pushNamed(
                                    RouteNames.orderChat,
                                  );
                                }
                              },
                              child: Image.asset(width: 40, AssetImages.chat)),
                          16.pw,
                          GestureDetector(
                              onTap: () async {
                                Utils.directCallBottomSheeet(
                                    context: context,
                                    mobileNumber:
                                        orderDeliveries.user!.mobileNumber!);
                              },
                              child: Image.asset(width: 40, AssetImages.call)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s8),
                topRight: Radius.circular(AppSize.s8),
              ),
            ),
          ),
          23.ph,
          Row(
            children: [
              29.05.pw,
              Image.asset(width: AppSize.s50, AssetImages.car),
              27.4.pw,
              SizedBox(
                width: 180,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "2012 honda civic",
                  style: getRegularStyle(
                      color: Color(0xFF242E42), fontSize: FontSize.s16),
                ),
              ),
              Spacer(),
              Text(
                "9195",
                style: getRegularStyle(
                    color: Color(0xFF242E42), fontSize: FontSize.s16),
              ),
              30.05.pw
            ],
          ),
          25.96.ph
        ],
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(AppSize.s8), color: Colors.white),
    );
  }
}

Future<String?> createChatRoom(
    UserModel userModel, ordermodel.OrderDeliveries deliveryAgent) async {
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('chatrooms');

  // Sort the participants array (to ensure the same order every time)
  List<String> participants = [
    userModel.user!.id!.toString(),
    deliveryAgent.deliveryAgentId!.toString()
  ]..sort(); // Ensure consistent order of participants

  // Check if a chatroom exists between these two users (with exact match of participants)
  QuerySnapshot existingChat =
      await chatRooms.where('participants', isEqualTo: participants).get();

  if (existingChat.docs.isNotEmpty) {
    // Chatroom already exists, return its ID
    return existingChat.docs.first.id;
  }

  // Create a new chatroom if not found
  DocumentReference newChatRoom = await chatRooms.add({
    'participants': participants, // Store participants in sorted order
    'lastMessage': '',
    'timestamp': FieldValue.serverTimestamp(),
  });

  return newChatRoom.id;
}
