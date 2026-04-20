import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../config/app_config.dart';

class DateTimeUtils {

  DateTimeUtils._();


  static final List<String> _bengaliNumbers = [
    '০',
    '১',
    '২',
    '৩',
    '৪',
    '৫',
    '৬',
    '৭',
    '৮',
    '৯'
  ];

  static final Map<String, String> _bengaliMonths = {
    'January': 'জানুয়ারি',
    'February': 'ফেব্রুয়ারি',
    'March': 'মার্চ',
    'April': 'এপ্রিল',
    'May': 'মে',
    'June': 'জুন',
    'July': 'জুলাই',
    'August': 'আগস্ট',
    'September': 'সেপ্টেম্বর',
    'October': 'অক্টোবর',
    'November': 'নভেম্বর',
    'December': 'ডিসেম্বর',
  };

  static final Map<String, String> _bengaliDays = {
    'Monday': 'সোমবার',
    'Tuesday': 'মঙ্গলবার',
    'Wednesday': 'বুধবার',
    'Thursday': 'বৃহস্পতিবার',
    'Friday': 'শুক্রবার',
    'Saturday': 'শনিবার',
    'Sunday': 'রবিবার',
  };

  // Convert UTC to local datetime
  static DateTime utcToLocal(DateTime utcDateTime) {
    return utcDateTime.toLocal();
  }

  // Get formatted date only (e.g., "2024-01-15")
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // Get formatted time only (e.g., "14:30")
  static String getFormattedTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  // Get day name in English (e.g., "Monday")
  static String getDayNameInEnglish(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  // Get day name in Bengali (e.g., "সোমবার")
  static String getDayNameInBengali(DateTime dateTime) {
    String englishDayName = getDayNameInEnglish(dateTime);
    return _bengaliDays[englishDayName] ?? englishDayName;
  }

  // Convert English date to Bengali (e.g., "15 January, 2024" to "১৫ জানুয়ারি, ২০২৪")
  static String convertToBengaliDate(DateTime dateTime) {
    String formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);
    List<String> parts = formattedDate.split(' ');

    // Convert day to Bengali
    String day = parts[0];
    String bengaliDay = day.split('').map((char) {
      int? digit = int.tryParse(char);
      return digit != null ? _bengaliNumbers[digit] : char;
    }).join('');

    // Convert month to Bengali
    String month = parts[1].replaceAll(',', '');
    String bengaliMonth = _bengaliMonths[month] ?? month;

    // Convert year to Bengali
    String year = parts[2];
    String bengaliYear = year.split('').map((char) {
      int? digit = int.tryParse(char);
      return digit != null ? _bengaliNumbers[digit] : char;
    }).join('');

    return '$bengaliDay $bengaliMonth, $bengaliYear';
  }

  // Get formatted datetime (e.g., "2024-01-15 14:30")
  static String getFormattedDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  // Get formatted date using user's preferred format from AppConfig
  static String getFormattedDateWithUserFormat(DateTime dateTime) {
    try {
      final appConfig = Get.find<AppConfig>();
      return appConfig.getFormattedDate(dateTime);
    } catch (e) {
      // Fallback if AppConfig not available
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  // Get formatted time using user's preferred format from AppConfig
  static String getFormattedTimeWithUserFormat(DateTime dateTime) {
    try {
      final appConfig = Get.find<AppConfig>();
      return appConfig.getFormattedTime(dateTime);
    } catch (e) {
      // Fallback if AppConfig not available
      return DateFormat('HH:mm').format(dateTime);
    }
  }

  // Get formatted datetime using user's preferred formats from AppConfig
  static String getFormattedDateTimeWithUserFormat(DateTime dateTime) {
    try {
      final appConfig = Get.find<AppConfig>();
      return '${appConfig.getFormattedDate(dateTime)} ${appConfig.getFormattedTime(dateTime)}';
    } catch (e) {
      // Fallback if AppConfig not available
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    }
  }
}
