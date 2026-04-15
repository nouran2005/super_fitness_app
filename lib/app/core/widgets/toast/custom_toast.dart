import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';

void showToast({
  required String title,
  required String description,
  required ToastificationType type,
  Duration? duration,
}) {
  toastification.show(
    animationDuration: duration,

    type: type,
    title: Text(title),
    description: Text(description),
    showIcon: true,
    closeButton: ToastCloseButton(),

    borderSide: BorderSide(
      width: 2,
      color: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.info
          ? Colors.blue
          : type == ToastificationType.warning
          ? Colors.orange
          : Colors.red,
    ),
    primaryColor: Colors.white,

    icon: Icon(
      Icons.error_rounded,
      size: 26,
      color: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.info
          ? Colors.blue
          : type == ToastificationType.warning
          ? Colors.orange
          : Colors.red,
    ),
    dragToClose: true,
    autoCloseDuration: const Duration(seconds: 3),

    backgroundColor: Color(0xffF8F8F8),

    foregroundColor: Colors.black,
  );
}
