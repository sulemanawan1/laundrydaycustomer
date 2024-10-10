import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

callNumber({required String mobileNumber}) async {
  bool? res = await FlutterPhoneDirectCaller.callNumber(mobileNumber);
}
