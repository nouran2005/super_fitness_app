import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:super_fitness_app/main.dart';

bool _loadingDialogVisible = false;
int _loadingDialogRequests = 0;
Timer? _loadingDialogTimer;
const Duration _loadingDialogDelay = Duration(milliseconds: 150);

Future<void> showLoadingDialog({String? message}) async {
  _loadingDialogRequests++;
  _scheduleLoadingDialog(message: message);
}

void _scheduleLoadingDialog({String? message}) {
  if (_loadingDialogTimer != null || _loadingDialogVisible) {
    return;
  }

  _loadingDialogTimer = Timer(_loadingDialogDelay, () {
    _loadingDialogTimer = null;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_loadingDialogRequests <= 0 || _loadingDialogVisible) {
        return;
      }

      final context = navigatorKey.currentContext;
      if (context == null) {
        return;
      }

      _loadingDialogVisible = true;
      await showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.25),
        builder: (_) {
          return PopScope(
            canPop: false,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Center(child: _LoadingContent(message: message)),
            ),
          );
        },
      ).whenComplete(() {
        _loadingDialogVisible = false;
      });

      if (_loadingDialogRequests > 0) {
        _scheduleLoadingDialog(message: message);
      }
    });
  });
}

class _LoadingContent extends StatelessWidget {
  final String? message;

  const _LoadingContent({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      padding: const EdgeInsets.symmetric(
        // horizontal: 24,
        // vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(size: 40, color: Colors.white),
          // const SizedBox(
          //   width: 40,
          //   height: 40,
          //   child: CircularProgressIndicator(
          //     strokeWidth: 3,
          //     color: Colors.white,
          //   ),
          // ),
          if (message != null) ...[
            const SizedBox(height: 14),
            Text(
              message!,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }
}

void hideLoadingDialog() {
  if (_loadingDialogRequests > 0) {
    _loadingDialogRequests--;
  }

  if (_loadingDialogRequests == 0) {
    _loadingDialogTimer?.cancel();
    _loadingDialogTimer = null;
  }

  if (_loadingDialogRequests != 0 || !_loadingDialogVisible) {
    return;
  }

  final navigatorState = navigatorKey.currentState;
  if (navigatorState == null || !navigatorState.mounted) {
    return;
  }

  navigatorState.pop();
}
