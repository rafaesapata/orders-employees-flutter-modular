import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_indicators_widget.dart';
import '../widgets/onboarding_navigation_widget.dart';
import '../widgets/onboarding_page_view_widget.dart';
import '../widgets/onboarding_skip_button_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = Modular.get<OnboardingController>();

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: Listenable.merge([
          _controller.pageController,
          _controller.pages,
          _controller.currentPage,
        ]),
        builder: (_, Widget? child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: SharedColors.brandMain,
            systemNavigationBarColor: SharedColors.brandMain,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: SharedColors.brandMain,
              body: Column(
                children: [
                  OnboardingSkipButton(
                    onPressed: () => _controller.completeOnboarding(),
                  ),
                  Expanded(
                    child: OnboardingPageViewWidget(
                      pageController: _controller.pageController,
                      pages: _controller.pages.value,
                      onPageChanged: _controller.onPageChanged,
                    ),
                  ),
                  OnboardingIndicatorsWidget(
                    currentPage: _controller.currentPage.value,
                    pages: _controller.pages.value,
                  ),
                  OnboardingNavigationWidget(
                    currentPage: _controller.currentPage.value,
                    nextPage: _controller.nextPage,
                    previousPage: _controller.previousPage,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
