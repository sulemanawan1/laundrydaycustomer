import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/app_services/card_utils.dart';
import 'package:laundryday/screens/add_new_card.dart/add_new_card_notifier.dart';
import 'package:laundryday/screens/add_new_card.dart/add_new_card_states.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';

final addNewCardProvider =
    StateNotifierProvider<AddNewCardNotifier, AddNewCardStates>(
        (ref) => AddNewCardNotifier());

class AddNewCard extends ConsumerStatefulWidget {
  const AddNewCard({super.key});

  @override
  ConsumerState<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends ConsumerState<AddNewCard> {
  TextEditingController cardNumberController = TextEditingController();

  CardType cardType = CardType.Invalid;

  @override
  void initState() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      
     
      
      appBar: MyAppBar(
        title: 'Add new Card',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(height: constraints.maxHeight*0.9,
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CardTypeIcon(image: 'assets/mada.jpg'),
                                  CardTypeIcon(image: 'assets/visa.png'),
                                  CardTypeIcon(image: 'assets/mastercard.png'),
                                  CardTypeIcon(image: 'assets/amex.png'),
                                ],
                              ),
                            ),
                          ),
                          20.ph,
                          const Divider(),
                          20.ph,
                          const CardLabel(label: 'Card Number'),
                          10.ph,
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(19),
                              CardNumberInputFormatter()
                            ],
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: ColorManager.greyColor,
                                  letterSpacing: 0.0),
                              contentPadding: const EdgeInsets.only(left: 20),
                              // suffix: CardUtils.getCardIcon(cardType),
                                            
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.2, color: ColorManager.greyColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.2, color: ColorManager.greyColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.2, color: ColorManager.greyColor)),
                              hintText: '0000 0000 0000 0000',
                            ),
                            validator: CardUtils.validateCardNum,
                          ),
                          20.ph,
                          const CardLabel(label: 'Name'),
                          10.ph,
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: ColorManager.greyColor,
                                  letterSpacing: 0.0),
                              contentPadding: const EdgeInsets.only(left: 20),
                              // suffix: CardUtils.getCardIcon(cardType),
                                            
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.2, color: ColorManager.greyColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.2, color: ColorManager.greyColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.2, color: ColorManager.greyColor)),
                                            
                              hintText: 'ex: Mada card',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                          20.ph,
                          const Row(
                            children: [
                              Expanded(
                                child: CardLabel(label: 'Expiry Date'),
                              ),
                              Expanded(
                                child: CardLabel(label: 'CVV Code'),
                              ),
                            ],
                          ),
                          10.ph,
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  onTap: () {},
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    CardMonthInputFormatter()
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintStyle: TextStyle(
                                        color: ColorManager.greyColor,
                                        letterSpacing: 0.0),
                                    errorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.2,
                                            color: ColorManager.greyColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.2,
                                            color: ColorManager.greyColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.2,
                                            color: ColorManager.greyColor)),
                                    hintText: 'MM   |   YY',
                                  ),
                                  validator: CardUtils.validateDate,
                                ),
                              ),
                              10.pw,
                              Flexible(
                                child: TextFormField(
                                  onTap: () {},
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    // Limit the input
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintStyle: TextStyle(
                                        color: ColorManager.greyColor,
                                        letterSpacing: 0.0),
                                    errorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.2,
                                            color: ColorManager.greyColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.2,
                                            color: ColorManager.greyColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.2,
                                            color: ColorManager.greyColor)),
                                    hintText: 'CVV',
                                  ),
                                  validator: CardUtils.validateCVV,
                                ),
                              ),
                            ],
                          ),
                          20.ph,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.amber.withOpacity(0.1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Note: You will be charged for an amount of 1 SR for\ncard verification which will be refunded Directly to your account.",
                                        style: GoogleFonts.poppins(
                                            color: ColorManager.blackColor),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.amber.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        10.ph,],
                      ),
                    ),
                  ),
                ),
                MyButton(
                  color: Colors.blue,
                  name: 'Add',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref
                          .read(addNewCardProvider.notifier)
                          .isCardValidate(isValidate: true);
                    }
                  },
                ),30.ph
               
              
              ],
            ),
          ),
        );
      }),
    );
  }

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }
}

class CardTypeIcon extends StatelessWidget {
  final String image;

  const CardTypeIcon({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: 26.0,
    );
  }
}

class CardLabel extends StatelessWidget {
  final String label;

  const CardLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeightManager.bold,
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
