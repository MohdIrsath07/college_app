import 'package:flutter/material.dart';
import 'package:college_app/constants/app_colors.dart';
import 'package:college_app/constants/app_styles.dart';
import 'package:college_app/widgets/custom_button.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const ErrorDialog({
    Key? key,
    this.title = 'Error',
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppStyles.heading2.copyWith(
          color: AppColors.errorColor,
        ),
      ),
      content: Text(
        message,
        style: AppStyles.bodyText1,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: CustomButton(
            label: buttonText,
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            height: 40,
          ),
        ),
      ],
    );
  }

  // Show the dialog
  static void show(
      BuildContext context, {
        String title = 'Error',
        required String message,
        String buttonText = 'OK',
        VoidCallback? onPressed,
      }) {
    showDialog(
      context: context,
      builder: (ctx) => ErrorDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}

// Success dialog
class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const SuccessDialog({
    Key? key,
    this.title = 'Success',
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppStyles.heading2.copyWith(
          color: AppColors.successColor,
        ),
      ),
      content: Text(
        message,
        style: AppStyles.bodyText1,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: CustomButton(
            label: buttonText,
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            type: ButtonType.primary,
            height: 40,
          ),
        ),
      ],
    );
  }

  // Show the dialog
  static void show(
      BuildContext context, {
        String title = 'Success',
        required String message,
        String buttonText = 'OK',
        VoidCallback? onPressed,
      }) {
    showDialog(
      context: context,
      builder: (ctx) => SuccessDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}

// Confirmation dialog
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppStyles.heading2,
      ),
      content: Text(
        message,
        style: AppStyles.bodyText1,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 8,
                  bottom: 16,
                ),
                child: CustomButton(
                  label: cancelText,
                  onPressed: onCancel ?? () => Navigator.of(context).pop(),
                  type: ButtonType.outline,
                  height: 40,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 16,
                  bottom: 16,
                ),
                child: CustomButton(
                  label: confirmText,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Show the dialog
  static void show(
      BuildContext context, {
        required String title,
        required String message,
        String confirmText = 'Confirm',
        String cancelText = 'Cancel',
        required VoidCallback onConfirm,
        VoidCallback? onCancel,
      }) {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

// Loading dialog
class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({
    Key? key,
    this.message = 'Loading...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppStyles.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Show the dialog
  static void show(
      BuildContext context, {
        String message = 'Loading...',
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => LoadingDialog(
        message: message,
      ),
    );
  }

  // Hide the dialog
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

// Information dialog
class InfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const InfoDialog({
    Key? key,
    this.title = 'Information',
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppStyles.heading2.copyWith(
          color: AppColors.infoColor,
        ),
      ),
      content: Text(
        message,
        style: AppStyles.bodyText1,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: CustomButton(
            label: buttonText,
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            type: ButtonType.secondary,
            height: 40,
          ),
        ),
      ],
    );
  }

  // Show the dialog
  static void show(
      BuildContext context, {
        String title = 'Information',
        required String message,
        String buttonText = 'OK',
        VoidCallback? onPressed,
      }) {
    showDialog(
      context: context,
      builder: (ctx) => InfoDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}