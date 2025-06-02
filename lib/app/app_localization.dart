import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../modules/shared/domain/consts/shared_globals_keys.dart';

abstract class Localization {
  static AppLocalizations get tr =>
      AppLocalizations.of(SharedGlobalsKeys.navigatorKey.currentContext!)!;
}
