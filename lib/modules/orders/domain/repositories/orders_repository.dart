import 'package:dartz/dartz.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<Result<List<OrderEntity>, Exception>> getOrders({
    int page = 1,
    int limit = 20,
    OrderStatus? status,
    String? search,
  });

  Future<Result<OrderEntity, Exception>> getOrderById(String id);

  Future<Result<OrderEntity, Exception>> createOrder(OrderEntity order);

  Future<Result<OrderEntity, Exception>> updateOrder(OrderEntity order);

  Future<Result<bool, Exception>> deleteOrder(String id);

  Future<Result<OrderEntity, Exception>> updateOrderStatus(
    String id,
    OrderStatus status,
  );

  Future<Result<Map<String, dynamic>, Exception>> getOrdersStats();
}

