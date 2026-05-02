import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';

class PrivacyPage extends StatelessWidget {
  PrivacyPage({super.key});

  bool _didScroll = false;
  WebViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBlurryBackground(
            blurSigmaX: 6,
            blurSigmaY: 6,
            blurAlpha: 40,
            image: Assets.imagesHomeBackground,
            widget: BlocConsumer<ProfileCubit, ProfileState>(
              listenWhen: (previous, current) => previous.help != current.help,
              listener: (context, state) {
                if (state.help != null &&
                    state.help!.isSuccess &&
                    controller == null) {
                  controller = WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(Colors.transparent)
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onPageFinished: (url) {
                          if (!_didScroll) {
                            _didScroll = true;
                            controller?.runJavaScript("window.scrollTo(0, 0);");
                          }
                        },
                      ),
                    )
                    ..loadRequest(Uri.parse(state.help!.data!));
                }
              },
              builder: (context, state) {
                if (state.help == null || state.help!.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.help!.isError) {
                  return Center(
                    child: Text(
                      state.help!.error ?? 'Error loading help data',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (controller != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 50,
                    ),
                    child: WebViewWidget(controller: controller!),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
            child: Align(
              alignment: AlignmentGeometry.topRight,
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 26,
                ),
                // child: Image.asset(Assets.imagesArrowBack),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
