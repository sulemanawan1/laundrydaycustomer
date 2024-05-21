import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/business_partner/view/business_partner.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/reusable_document_picker.dart';

class CommercialRegistrationImage extends ConsumerWidget {
  const CommercialRegistrationImage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(bussinessPartnerProvider);

    return Card(
      color: ColorManager.whiteColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.ph,
            HeadingMedium(title: 'Upload required files'),
            8.ph,
            ResuableDocumentPicker(
                onTap: () {
                  ref
                      .read(bussinessPartnerProvider.notifier)
                      .pickImage(imageSource: ImageSource.gallery);
                },
                imageFile: states.image,
                title: "Commercial Registration Image"),
            8.ph
          ],
        ),
      ),
    );
  }
}
