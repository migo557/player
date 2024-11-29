// import 'package:flutter/material.dart';
// import 'package:floating/floating.dart';
// import 'package:open_player/base/di/injection.dart';

// class PictureInPictureService {
//   /// Attempts to enable Picture-in-Picture mode
//   ///
//   /// Returns a [PiPResult] indicating the outcome of the PiP attempt
//   Future<PiPResult> enablePictureInPicture(BuildContext context) async {
//     try {
//       // Use service locator to get Floating instance
//       final floating = locator<Floating>();

//       // Check if PiP is available
//       final bool canUsePiP = await floating.isPipAvailable;

//       if (!canUsePiP) {
//         _showPiPUnavailableSnackbar(context);
//         return PiPResult(
//             success: false,
//             errorMessage: 'Picture-in-Picture is not available on this device');
//       }

//       // Attempt to enable PiP
//       await floating.enable(ImmediatePiP());

//       return PiPResult(success: true, errorMessage: null);
//     } catch (e) {
//       // Handle any unexpected errors
//       _showPiPErrorSnackbar(context, e);
//       return PiPResult(
//           success: false,
//           errorMessage: 'Failed to enter Picture-in-Picture mode: $e');
//     }
//   }

//   /// Show a snackbar when PiP is unavailable
//   void _showPiPUnavailableSnackbar(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Picture-in-Picture is not supported on this device'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   /// Show a snackbar when there's an error entering PiP
//   void _showPiPErrorSnackbar(BuildContext context, dynamic error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to enter Picture-in-Picture: $error'),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }

// /// Represents the result of a Picture-in-Picture operation
// class PiPResult {
//   final bool success;
//   final String? errorMessage;

//   PiPResult({
//     required this.success,
//     this.errorMessage,
//   });
// }
