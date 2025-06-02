import 'package:flutter/foundation.dart';

import '../entities/failure_data_entity.dart';
import '../enums/shared_enum_page_state.dart';

abstract class SharedBaseController extends ChangeNotifier {
  final pageState = ValueNotifier(SharedEnumPageState.ready);
  final isValid = ValueNotifier(false);
  final isLoading = ValueNotifier(false);
  final failure = ValueNotifier<FailureDataEntity?>(null);
}
