import 'dart:developer';
import 'package:flutter/material.dart';

bool haveNameAljabrOrAlrahden({required String laundryName}) {
  String name = laundryName.trim().toLowerCase();
  String withoutSpaceName = name.replaceAll(' ', '');
  name = withoutSpaceName;
  return name.contains('الجبر') ||
      name.contains('aljabr') ||
      name.contains('الرهدن') ||
      name.contains('alrahden');
}

bool hasNameAlrahden({required String laundryName}) {
  String name = laundryName.trim().toLowerCase();
  String withoutSpaceName = name.replaceAll(' ', '');
  name = withoutSpaceName;
  return name.contains('الرهدن') || name.contains('alrahden');
}

bool hasNameAljabr({required String laundryName}) {
  String name = laundryName.trim().toLowerCase();
  String withoutSpaceName = name.replaceAll(' ', '');
  name = withoutSpaceName;
  return name.contains('الجبر') || name.contains('aljabr');
}


class LaundryTimings {
  final bool isOpen;
  final String? morningStart; // Nullable for laundries without a pickup time.
  final String? morningEnd; // Nullable for laundries without a pickup time.
  final String? breakStart;
  final String? breakEnd;
  LaundryTimings(
      {required this.isOpen,
      this.morningStart,
      required this.morningEnd,
      required this.breakStart,
      this.breakEnd});
}

LaundryTimings getAlajabrOrAlrahdenTimings() {
  final now = DateTime.now();
  final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

  // Adjust morning start time based on the day of the week
  final isFriday = now.weekday == DateTime.friday;
  final morningStart = isFriday
      ? TimeOfDay(hour: 12, minute: 30) // 12:30 pm on Fridays
      : TimeOfDay(hour: 9, minute: 0); // 9:00 am on other days

  final morningEnd = TimeOfDay(hour: 23, minute: 30); // 11:30 pm
  final breakStart = TimeOfDay(hour: 14, minute: 0); // 2:00 pm
  final breakEnd = TimeOfDay(hour: 16, minute: 0); // 4:00 pm

  // Check if current time is within operating hours but not during the break
  if (isWithinTime(currentTime, morningStart, morningEnd) &&
      !isWithinTime(currentTime, breakStart, breakEnd)) {
    return LaundryTimings(
        morningEnd: formatTimeOfDay(morningEnd),
        morningStart: formatTimeOfDay(morningStart),
        isOpen: true,
        breakStart: formatTimeOfDay(breakStart),
        breakEnd: formatTimeOfDay(breakEnd));
  }
  return LaundryTimings(
      morningEnd: formatTimeOfDay(morningEnd),
      morningStart: formatTimeOfDay(morningStart),
      isOpen: false,
      breakStart: formatTimeOfDay(breakStart),
      breakEnd: formatTimeOfDay(breakEnd));
}

bool isWithinTime(
    TimeOfDay currentTime, TimeOfDay startTime, TimeOfDay endTime) {
  final currentMinutes = currentTime.hour * 60 + currentTime.minute;
  final startMinutes = startTime.hour * 60 + startTime.minute;
  final endMinutes = endTime.hour * 60 + endTime.minute;

  return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
}

class LaundryPickupStatus {
  final bool isOpen;
  final String? pickupStart; // Nullable for laundries without a pickup time.

  LaundryPickupStatus({required this.isOpen, this.pickupStart});
}

bool isWithinPickupTime(
    TimeOfDay currentTime, TimeOfDay startTime, TimeOfDay endTime) {
  final currentMinutes = currentTime.hour * 60 + currentTime.minute;
  final startMinutes = startTime.hour * 60 + startTime.minute;
  final endMinutes = endTime.hour * 60 + endTime.minute;

  return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
}

/// Formats a TimeOfDay object as a readable string.
String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0
      ? 12
      : time.hourOfPeriod; // Adjust for 12-hour clock
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

LaundryPickupStatus getPickupTimeStatus(String laundryName) {
  final now = DateTime.now();
  final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
  String name = laundryName.toLowerCase().trim();

  log('Laundry Name $name');
  if (name.contains('الجبر') || name.contains('aljabr')) {
    // الجبر Pickup Time: 10:00 PM to 11:30 PM
    final pickupStart = TimeOfDay(hour: 22, minute: 0); // 10:00 PM
    final pickupEnd = TimeOfDay(hour: 23, minute: 30); // 11:30 PM
    final isOpen = isWithinPickupTime(currentTime, pickupStart, pickupEnd);
    return LaundryPickupStatus(
      isOpen: isOpen,
      pickupStart:
          "You can pick up the order from this laundry after ${formatTimeOfDay(pickupStart)}",
    );
  } else if (name.contains('الرهدن') || name.contains('alrahden')) {
    // الرهدن Pickup Time: 7:00 PM to 11:30 PM
    final pickupStart = TimeOfDay(hour: 19, minute: 0); // 7:00 PM
    final pickupEnd = TimeOfDay(hour: 23, minute: 30); // 11:30 PM
    final isOpen = isWithinPickupTime(currentTime, pickupStart, pickupEnd);
    return LaundryPickupStatus(
      isOpen: isOpen,
      pickupStart:
          "You can pick up the order from this laundry after ${formatTimeOfDay(pickupStart)}",
    );
  } else {
    // Other laundries: Pickup is always open
    return LaundryPickupStatus(isOpen: true, pickupStart: "Always Open");
  }
}
