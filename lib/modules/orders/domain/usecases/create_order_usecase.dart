import 'package:result_dart/result_dart.dart';

import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

abstract class CreateOrderUseCase {
  Future<Result<OrderEntity, Exception>> call(OrderEntity order);
}

class CreateOrderUseCaseImp implements CreateOrderUseCase {
  final OrdersRepository _repository;

  CreateOrderUseCaseImp(this._repository);

  @override
  Future<Result<OrderEntity, Exception>> call(OrderEntity order) async {
    // Validações de negócio
    if (order.items.isEmpty) {
      return Failure(Exception('Pedido deve conter pelo menos um item'));
    }

    if (order.totalAmount <= 0) {
      return Failure(Exception('Valor total deve ser maior que zero'));
    }

    if (order.customerName.trim().isEmpty) {
      return Failure(Exception('Nome do cliente é obrigatório'));
    }

    if (order.customerEmail.trim().isEmpty) {
      return Failure(Exception('Email do cliente é obrigatório'));
    }

    // Validar email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(order.customerEmail)) {
      return Failure(Exception('Email do cliente inválido'));
    }

    return await _repository.createOrder(order);
  }
}

