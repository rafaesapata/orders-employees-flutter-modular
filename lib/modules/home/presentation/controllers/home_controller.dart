// Todos os tipos de cases que podem ser utilizados

import 'package:flutter/material.dart';

enum HomePageState { loading, ready, error, success, empty }

abstract class IHomeController extends ChangeNotifier {
  bool get isLoading;
  HomePageState get pageState;
  ValueNotifier<int> get currentPageIndex;
  void onChangePage(int page);
  PageController get pageController;
}

class HomeController extends IHomeController {
  @override
  get isLoading => pageState == HomePageState.loading;

  @override
  HomePageState pageState = HomePageState.ready;

  @override
  PageController pageController = PageController();

  @override
  ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  @override
  void onChangePage(int page) {
    currentPageIndex.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: currentPageIndex.value > page ? Curves.bounceIn : Curves.bounceOut,
    );
  }
}
