import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/app_localization.dart';
import '../../../access/access_routes.dart';
import '../../../shared/domain/consts/shared_icons.dart';
import '../../../shared/domain/enums/shared_enum_prefs_keys.dart';
import '../../data/model/onboarding_data_model.dart';

abstract class OnboardingController extends ChangeNotifier {
  PageController get pageController;
  ValueNotifier<List<OnboardingDataModel>> get pages;
  ValueNotifier<int> get currentPage;
  void onPageChanged(int index);
  void previousPage();
  void nextPage();
  void completeOnboarding();
}

class OnboardingControllerImp extends OnboardingController {
  late final SharedPreferences _sharedPreferences;

  @override
  final pageController = PageController();

  @override
  final pages = ValueNotifier(<OnboardingDataModel>[
    OnboardingDataModel(
      title: Localization.tr.onboardingTitleSolutions,
      description: Localization.tr.onboardingDescriptionSolutions,
      icon: SharedIcons.onboardingSolution,
    ),
    OnboardingDataModel(
      title: Localization.tr.onboardingTitlePartnership,
      description: Localization.tr.onboardingDescriptionPartnership,
      icon: SharedIcons.onboardingPartnership,
    ),
    OnboardingDataModel(
      title: Localization.tr.onboardingTitleTransformation,
      description: Localization.tr.onboardingDescriptionTransformation,
      icon: SharedIcons.onboardingRocket,
    ),
  ]);

  @override
  ValueNotifier<int> currentPage = ValueNotifier(0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void nextPage() async {
    if (currentPage.value >= pages.value.length - 1) {
      completeOnboarding();
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void completeOnboarding() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setBool(
      SharedEnumPrefsKeys.onboardingDoneKey.key,
      true,
    );
    Modular.to.pushReplacementNamed(AccessRoutes.access);
  }
}
