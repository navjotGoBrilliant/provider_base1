import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Extension class for `DateTime` to provide a convenient `format` method.
extension DateTimeFormat on DateTime {
  /// Formats the `DateTime` object according to the specified pattern.
  ///
  /// Uses the `intl` package for formatting.  If no pattern is provided,
  /// defaults to 'yyyy-MM-dd HH:mm:ss'.
  ///
  /// Example:
  /// ```dart
  /// final now = DateTime.now();
  /// final formattedDate = now.format('dd/MM/yyyy'); // e.g., 24/07/2024
  /// final formattedTime = now.format('HH:mm:ss');       // e.g., 14:35:20
  /// final formattedDateTime = now.format('yyyy-MM-dd HH:mm:ss'); // e.g., 2024-07-24 14:35:20
  /// final formattedDateUS = now.format('MM/dd/yyyy');  // e.g., 07/24/2024
  /// ```
  ///
  /// Parameters:
  ///   - `pattern`: The format pattern string.  See the `intl` package
  ///                documentation for available patterns.
  ///                Defaults to 'yyyy-MM-dd HH:mm:ss'.
  ///   - `locale`:  Optional.  The locale to use for formatting. If not provided,
  ///                the system's default locale will be used.
  ///
  /// Returns:
  ///   The formatted date and time string.  Returns an empty string if the
  ///   pattern is null or empty.
  String format([String pattern = 'yyyy-MM-dd HH:mm:ss', String? locale]) {
    if (pattern.isEmpty) {
      return '';
    }
    try {
      if (locale != null && locale.isNotEmpty) {
        return DateFormat(pattern, locale).format(this);
      }
      return DateFormat(pattern).format(this);
    } catch (e) {
      // Handle any exceptions during formatting, such as invalid patterns.
      if (kDebugMode) {
        print('Error formatting DateTime: $e');
      } // Log the error
      return ''; // Return empty string.  Consider returning a default format or null.
    }
  }
}

/*void main() {
  final now = DateTime.now();

  // Example Usage
  final formattedDefault = now.format();
  final formattedDate = now.format('dd/MM/yyyy');
  final formattedTime = now.format('HH:mm:ss');
  final formattedDateTime = now.format('yyyy-MM-dd HH:mm:ss');
  final formattedDateUS = now.format('MM/dd/yyyy');
  final formattedWithLocale = now.format('dd MMMM yyyy', 'fr_FR'); // Example with French locale

  if (kDebugMode) {
    print('Default format: $formattedDefault');
    print('Formatted Date (dd/MM/yyyy): $formattedDate');
    print('Formatted Time (HH:mm:ss): $formattedTime');
    print('Formatted DateTime (yyyy-MM-dd HH:mm:ss): $formattedDateTime');
    print('Formatted Date (US - MM/dd/yyyy): $formattedDateUS');
    print('Formatted with French locale: $formattedWithLocale');
  }


  final invalidDate = DateTime.tryParse('invalid date');
  if (invalidDate != null) { //Important null check
    final formattedInvalid = invalidDate.format('yyyy-MM-dd');
    if (kDebugMode) {
      print("Invalid date formatted: $formattedInvalid");
    }
  }

}*/
