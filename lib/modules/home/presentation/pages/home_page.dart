import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/domain/consts/shared_icons.dart';
import '../../../shared/domain/extensions/shared_extensions_string.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../shared/presentation/widgets/shared_bottom_navigation_bar.dart';
import '../../../shared/presentation/widgets/shared_full_screen_loading.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final IHomeController controller = Modular.get();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: SharedColors.background,
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: controller.currentPageIndex,
            builder: (context, value, child) => SharedBottomNavigationBar(
              onPageChanged: controller.onChangePage,
              currentIndex: value,
            ),
          ),
          body: AnimatedBuilder(
            animation: controller,
            builder: (context, widget) {
              if (controller.isLoading) {
                return const SharedFullScreenLoading();
              }
              if (controller.pageState == HomePageState.error) {
                return Container();
              }
              return _makeContent(context);
            },
          ),
        )),
      );

  _makeContent(BuildContext context) => PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          Container(
            color: SharedColors.brandDark,
            child: Center(child: SharedIcons.logo.icon()),
          ),
          Container(
            color: SharedColors.brandMain,
            child: Center(child: SharedIcons.logo.icon()),
          ),
          Container(
            color: SharedColors.brandLight,
            child: Center(child: SharedIcons.logo.icon()),
          ),
          Container(
            color: SharedColors.warning,
            child: Center(child: SharedIcons.logo.icon()),
          ),
        ],
      );
}
