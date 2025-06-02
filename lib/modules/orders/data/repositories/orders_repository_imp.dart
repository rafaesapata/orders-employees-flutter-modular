import 'package:result_dart/result_dart.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_datasource.dart';

class OrdersRepositoryImp implements OrdersRepository {
  final OrdersDatasource _datasource;

  OrdersRepositoryImp(this._datasource);

  @override
  Future<Result<List<OrderEntity>, Exception>> getOrders({
    int page = 1,
    int limit = 20,
    OrderStatus? status,
    String? search,
  }) async {
    return await _datasource.getOrders(
      page: page,
      limit: limit,
      status: status,
      search: search,
    );
  }

  @override
  Future<Result<OrderEntity, Exception>> getOrderById(String id) async {
    return await _datasource.getOrderById(id);
  }

  @override
  Future<Result<OrderEntity, Exception>> createOrder(OrderEntity order) async {
    return await _datasource.createOrder(order);
  }

  @override
  Future<Result<OrderEntity, Exception>> updateOrder(OrderEntity order) async {
    return await _datasource.updateOrder(order);
  }

  @override
  Future<Result<bool, Exception>> deleteOrder(String id) async {
    return await _datasource.deleteOrder(id);
  }

  @override
  Future<Result<OrderEntity, Exception>> updateOrderStatus(
    String id,
    OrderStatus status,
  ) async {
    return await _datasource.updateOrderStatus(id, status);
  }

  @override
  Future<Result<Map<String, dynamic>, Exception>> getOrdersStats() async {
    return await _datasource.getOrdersStats();
  }
}

