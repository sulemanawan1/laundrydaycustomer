import 'dart:ui';

class SettingStates {
  List<Locale> locales;
  String? savedLocale;
  bool? pushNotifcation;
  SettingStates({
    this.pushNotifcation,
    this.savedLocale,
    required this.locales,
  });

  SettingStates copyWith({List<Locale>? locales, String? savedLocale,  
  bool? pushNotifcation
}) {
    return SettingStates(
      pushNotifcation:pushNotifcation??this.pushNotifcation,
      savedLocale: savedLocale ?? this.savedLocale,
      locales: locales ?? this.locales,
    );
  }
}
