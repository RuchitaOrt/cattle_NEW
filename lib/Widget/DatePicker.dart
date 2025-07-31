import 'package:cattle/Utils/cattle_colors.dart';
import 'package:flutter/material.dart';

Future<void> showCattleDatePicker({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: CattleColors.orange,
          colorScheme: ColorScheme.light(primary: CattleColors.orange),
          datePickerTheme: const DatePickerThemeData(
           
            
           
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    // Delay to ensure dialog closes smoothly before updating text
    await Future.delayed(const Duration(milliseconds: 100));
    controller.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
  }
}
Future<void> showCattleTimePicker({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            hourMinuteTextColor: CattleColors.orange,
            dayPeriodTextColor: CattleColors.orange,
            dialHandColor: CattleColors.orange,
            entryModeIconColor: CattleColors.orange,
            hourMinuteColor: CattleColors.orange.withOpacity(0.1),
            helpTextStyle: TextStyle(color: CattleColors.orange),
          ),
          colorScheme: ColorScheme.light(primary: CattleColors.orange),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    final hour = picked.hourOfPeriod.toString().padLeft(2, '0');
    final minute = picked.minute.toString().padLeft(2, '0');
    final period = picked.period == DayPeriod.am ? "AM" : "PM";
    controller.text = "$hour:$minute $period";
  }
}