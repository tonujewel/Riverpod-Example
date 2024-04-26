import 'package:flutter/material.dart';

class DialogHelper {
  //show toast
  //show snack bar
  //show loading
  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void animatedDialog({
    required BuildContext context,
    required Widget child,
    bool? dismissable,
  }) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.4, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.4, end: 1.0).animate(a1),
              child: widget,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        barrierDismissible: dismissable ?? true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SafeArea(
            child: Dialog(
              backgroundColor: Colors.white,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              insetPadding: const EdgeInsets.all(24),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: child,
            ),
          );
        });
  }
}
