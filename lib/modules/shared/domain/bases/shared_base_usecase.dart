import 'package:result_dart/result_dart.dart';

import '../../submodules/rest/domain/failures/rest_failure.dart';

abstract class SharedBaseUsecaseInputOutput<Input, Output extends Object> {
  AsyncResult<Output, RestFailure> call(Input param);
}

abstract class SharedBaseUsecaseOutput<Output extends Object> {
  AsyncResult<Output, RestFailure> call();
}

abstract class SharedBaseUsecaseInput<Input extends Object> {
  AsyncResult<Unit, RestFailure> call(Input param);
}

abstract class SharedBaseUsecase {
  AsyncResult<Unit, RestFailure> call();
}
