import '../../domain/entities/rest_response_entity.dart';

class RestResponseModel<T> extends RestResponseEntity<T> {
  RestResponseModel({
    super.data,
    super.statusCode,
    super.statusMessage,
  });
}
