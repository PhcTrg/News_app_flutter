// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';

// const String dateTimeFormatPattern = 'dd/MM/yyyy';

// extension DateTimeExtension on DateTime {
//   String format({
//     String pattern = dateTimeFormatPattern,
//     String? locale,
//   }) {
//     if (locale != null && locale.isNotEmpty) {
//       initializeDateFormatting(locale);
//     }
//     return DateFormat(pattern, locale).format(this);
//   }
// }

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 1) {
    return '${difference.inDays} days ago';
  } else if (difference.inHours > 1) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 1) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'just now';
  }
}
