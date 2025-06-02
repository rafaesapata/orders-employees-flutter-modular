import 'package:result_dart/result_dart.dart';

import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

abstract class GetOrdersUseCase {
  Future<Result<List<OrderEntity>, Exception>> call({
    int page = 1,
    int limit = 20,
    OrderStatus? status,
    String? search,
  });
}

class GetOrdersUseCaseImp implements GetOrdersUseCase {
  final OrdersRepository _repository;

  GetOrdersUseCaseImp(this._repository);

  @override
  Future<Result<List<OrderEntity>, Exception>> call({
    int page = 1,
    int limit = 20,
    OrderStatus? status,
    String? search,
  }) async {
    return await _repository.getOrders(
      page: page,
      limit: limit,
      status: status,
      search: search,
    );
  }
}

