import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/create_order_usecase.dart';

enum OrdersPageState { loading, ready, error, success, empty }

abstract class OrdersController extends ChangeNotifier {
  ValueNotifier<OrdersPageState> get state;
  ValueNotifier<List<OrderEntity>> get orders;
  ValueNotifier<String?> get errorMessage;
  ValueNotifier<bool> get isLoading;
  ValueNotifier<OrderStatus?> get selectedStatus;
  ValueNotifier<String> get searchQuery;

  Future<void> initialize();
  Future<void> loadOrders();
  Future<void> refreshOrders();
  Future<void> filterByStatus(OrderStatus? status);
  Future<void> searchOrders(String query);
  Future<void> createOrder(OrderEntity order);
  void clearError();
}

class OrdersControllerImp extends OrdersController {
  final GetOrdersUseCase _getOrdersUseCase;
  final CreateOrderUseCase _createOrderUseCase;

  @override
  final state = ValueNotifier<OrdersPageState>(OrdersPageState.loading);

  @override
  final orders = ValueNotifier<List<OrderEntity>>([]);

  @override
  final errorMessage = ValueNotifier<String?>(null);

  @override
  final isLoading = ValueNotifier<bool>(false);

  @override
  final selectedStatus = ValueNotifier<OrderStatus?>(null);

  @override
  final searchQuery = ValueNotifier<String>('');

  OrdersControllerImp({
    required GetOrdersUseCase getOrdersUseCase,
    required CreateOrderUseCase createOrderUseCase,
  })  : _getOrdersUseCase = getOrdersUseCase,
        _createOrderUseCase = createOrderUseCase;

  @override
  Future<void> initialize() async {
    await loadOrders();
  }

  @override
  Future<void> loadOrders() async {
    state.value = OrdersPageState.loading;
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _getOrdersUseCase(
      status: selectedStatus.value,
      search: searchQuery.value.isEmpty ? null : searchQuery.value,
    );

    result.fold(
      (success) {
        orders.value = success;
        state.value = success.isEmpty 
            ? OrdersPageState.empty 
            : OrdersPageState.ready;
      },
      (error) {
        errorMessage.value = error.toString();
        state.value = OrdersPageState.error;
      },
    );

    isLoading.value = false;
    notifyListeners();
  }

  @override
  Future<void> refreshOrders() async {
    await loadOrders();
  }

  @override
  Future<void> filterByStatus(OrderStatus? status) async {
    selectedStatus.value = status;
    await loadOrders();
  }

  @override
  Future<void> searchOrders(String query) async {
    searchQuery.value = query;
    await loadOrders();
  }

  @override
  Future<void> createOrder(OrderEntity order) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _createOrderUseCase(order);

    result.fold(
      (success) {
        // Adicionar o novo pedido à lista
        orders.value = [success, ...orders.value];
        state.value = OrdersPageState.success;
      },
      (error) {
        errorMessage.value = error.toString();
        state.value = OrdersPageState.error;
      },
    );

    isLoading.value = false;
    notifyListeners();
  }

  @override
  void clearError() {
    errorMessage.value = null;
    if (state.value == OrdersPageState.error) {
      state.value = orders.value.isEmpty 
          ? OrdersPageState.empty 
          : OrdersPageState.ready;
    }
    notifyListeners();
  }
}

