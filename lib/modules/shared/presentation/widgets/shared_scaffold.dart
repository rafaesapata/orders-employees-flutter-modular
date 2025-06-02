import 'package:flutter/material.dart';

import '../../domain/bases/shared_base_controller.dart';
import '../../domain/consts/shared_dimens.dart';
import '../../domain/enums/shared_enum_failure_launch_type.dart';
import '../../domain/enums/shared_enum_page_state.dart';
import '../../domain/extensions/shared_extensions_build_context.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../components/shared_alert_bottom_sheet.dart';
import '../components/shared_snack_bar.dart';
import 'shared_full_screen_loading.dart';
import 'shared_single_child_scroll_view.dart';

class SharedScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? largeTitle;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final SharedBaseController? baseController;

  const SharedScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.largeTitle,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.baseController,
  });

  @override
  State<SharedScaffold> createState() => _SharedScaffoldState();
}

class _SharedScaffoldState extends State<SharedScaffold> {
  final _isLoadingNotifier = ValueNotifier(false);

  void _failureListener() {
    final failure = widget.baseController?.failure.value;
    if (failure == null) {
      return;
    }
    widget.baseController?.failure.value = null;

    if (failure.launchType.isSnackBar) {
      showSnackBar(message: failure.message, callback: failure.callback);
    } else {
      showErrorBottomSheet(
        context: context,
        title: failure.title,
        message: failure.message,
        onConfirm: failure.callback,
      );
    }
  }

  void _loadingListener() => _isLoadingNotifier.value =
      widget.baseController?.isLoading.value ?? false;

  void _pageStateListener() {
    _isLoadingNotifier.value =
        widget.baseController?.pageState.value.isLoading ?? false;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.baseController?.failure.addListener(_failureListener);
      widget.baseController?.isLoading.addListener(_loadingListener);
      widget.baseController?.pageState.addListener(_pageStateListener);
    });
  }

  @override
  void dispose() {
    widget.baseController?.failure.removeListener(_failureListener);
    widget.baseController?.isLoading.removeListener(_loadingListener);
    widget.baseController?.pageState.removeListener(_pageStateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: _isLoadingNotifier,
        builder: (context, isLoading, child) => IgnorePointer(
          ignoring: isLoading,
          child: Scaffold(
            appBar: widget.appBar,
            backgroundColor: SharedColors.background,
            bottomSheet: widget.bottomSheet,
            bottomNavigationBar: widget.bottomNavigationBar,
            body: Stack(
              children: [
                GestureDetector(
                  onTap: context.closeKeyboard,
                  child: Visibility(
                    visible: context.isTablet,
                    replacement: _makeMobilePage(context),
                    child: _makeTabletPage(context),
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: SharedFullScreenLoading(),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _makeMobilePage(BuildContext context) => widget.body;

  Widget _makeTabletPage(BuildContext context) => Center(
        child: SharedSingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SharedDimens.medium,
            ),
            child: SizedBox(
              width: context.width * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.largeTitle != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: SharedDimens.medium,
                      ),
                      child: widget.largeTitle,
                    ),
                  widget.body,
                ],
              ),
            ),
          ),
        ),
      );
}
