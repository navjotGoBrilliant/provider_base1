import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

/// A utility class to handle common permission requests using the `permission_handler` package.
class PermissionHandlerUtil {
  /// Checks if the given permission is granted.
  ///
  /// Returns `true` if the permission is granted, `false` otherwise.
  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status == PermissionStatus.granted;
  }

  /// Requests the given permission.
  ///
  /// Returns `true` if the permission is granted after the request, `false` otherwise.
  ///
  /// Handles edge cases like restricted or permanently denied permissions,
  /// showing dialogs to guide the user to the app settings.
  static Future<bool> requestPermission(
      Permission permission, {
        String? rationaleTitle,
        String? rationaleMessage,
        BuildContext? context, // Make context nullable
      }) async {
    final status = await permission.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      return false; // Permission denied, do not show dialog
    } else if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      // Show a dialog to the user explaining why the permission is needed
      // and how to enable it in the app settings.
      if (context != null) { // Check if context is not null before using it.
        await _showPermissionSettingsDialog(
          context,
          rationaleTitle: rationaleTitle,
          rationaleMessage: rationaleMessage,
        );
      }
      return await isPermissionGranted(permission); // Check again after user interaction
    } else {
      return false; // Handle other statuses as denied.
    }
  }

  /// Opens the app settings page.
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Shows a dialog explaining why a permission is needed and how to enable it in settings.
  ///
  /// The dialog provides an option for the user to directly open the app settings.
  static Future<void> _showPermissionSettingsDialog(
      BuildContext context, {
        String? rationaleTitle, // Optional title
        String? rationaleMessage, // Optional message
      }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(rationaleTitle ?? 'Permission Required'), // Default title
        content: Text(
          rationaleMessage ??
              'To use this feature, we need this permission. Please enable it in the app settings.', // Default message
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Checks and requests a list of permissions.
  ///
  /// Returns a map of permissions and their statuses.
  ///
  /// Example Usage:
  /// ```dart
  /// final permissions = [Permission.camera, Permission.microphone];
  /// final statuses = await PermissionHandlerUtil.requestMultiplePermissions(permissions);
  /// if (statuses[Permission.camera] == PermissionStatus.granted &&
  ///     statuses[Permission.microphone] == PermissionStatus.granted) {
  ///   // do something
  /// } else {
  ///  // handle
  /// }
  /// ```
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
      List<Permission> permissions,
      {BuildContext? context}) async {
    // Use the built-in request method of the PermissionHandler class.
    final Map<Permission, PermissionStatus> statuses = await permissions.request();

    // Handle permanently denied permissions by showing a dialog.
    for (final entry in statuses.entries) {
      if (entry.value == PermissionStatus.permanentlyDenied && context != null) {
        await _showPermissionSettingsDialog(context);
        // After showing the dialog, re-check the permission status.
        final newStatus = await entry.key.status;
        statuses[entry.key] = newStatus; //update the status.
      }
    }
    return statuses;
  }
}
