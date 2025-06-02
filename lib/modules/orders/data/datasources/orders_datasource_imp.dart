import 'package:result_dart/result_dart.dart';

import '../../../shared/submodules/rest/data/provider/rest_provider.dart';
import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';
import 'orders_datasource.dart';

class OrdersDatasourceImp implements OrdersDatasource {
  final RestProvider _restProvider;

  OrdersDatasourceImp(this._restProvider);

  @override
  Future<Result<List<OrderEntity>, Exception>> getOrders({
    int page = 1,
    int limit = 20,
    OrderStatus? status,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (status != null) 'status': status.value,
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final response = await _restProvider.get(
        '/orders',
        queryParameters: queryParams,
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> data = response.data['data'] ?? [];
        final orders = data
            .map((json) => OrderModel.fromJson(json).toEntity())
            .toList();
        return Success(orders);
      } else {
        return Failure(Exception('Erro ao buscar pedidos: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<OrderEntity, Exception>> getOrderById(String id) async {
    try {
      final response = await _restProvider.get('/orders/$id');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final orderModel = OrderModel.fromJson(response.data);
        return Success(orderModel.toEntity());
      } else {
        return Failure(Exception('Erro ao buscar pedido: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<OrderEntity, Exception>> createOrder(OrderEntity order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final response = await _restProvider.post(
        '/orders',
        data: orderModel.toJson(),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final createdOrder = OrderModel.fromJson(response.data);
        return Success(createdOrder.toEntity());
      } else {
        return Failure(Exception('Erro ao criar pedido: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<OrderEntity, Exception>> updateOrder(OrderEntity order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final response = await _restProvider.put(
        '/orders/${order.id}',
        data: orderModel.toJson(),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final updatedOrder = OrderModel.fromJson(response.data);
        return Success(updatedOrder.toEntity());
      } else {
        return Failure(Exception('Erro ao atualizar pedido: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<bool, Exception>> deleteOrder(String id) async {
    try {
      final response = await _restProvider.delete('/orders/$id');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return const Success(true);
      } else {
        return Failure(Exception('Erro ao excluir pedido: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<OrderEntity, Exception>> updateOrderStatus(
    String id,
    OrderStatus status,
  ) async {
    try {
      final response = await _restProvider.put(
        '/orders/$id/status',
        data: {'status': status.value},
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final updatedOrder = OrderModel.fromJson(response.data);
        return Success(updatedOrder.toEntity());
      } else {
        return Failure(Exception('Erro ao atualizar status: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<Map<String, dynamic>, Exception>> getOrdersStats() async {
    try {
      final response = await _restProvider.get('/orders/stats');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return Success(response.data);
      } else {
        return Failure(Exception('Erro ao buscar estatísticas: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }
}

