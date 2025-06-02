import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../shared/presentation/widgets/shared_height.dart';
import '../../domain/entities/order_entity.dart';
import '../controllers/orders_controller.dart';

class OrdersListPage extends StatefulWidget {
  const OrdersListPage({super.key});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  final OrdersController controller = Modular.get();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.initialize());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pedidos'),
            backgroundColor: SharedColors.brandMain,
            foregroundColor: SharedColors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // TODO: Navegar para tela de criação de pedido
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(SharedDimens.medium),
                color: SharedColors.textFieldBackground,
                child: Column(
                  children: [
                    // Campo de busca
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar pedidos...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: SharedColors.white,
                      ),
                      onChanged: (value) => controller.searchOrders(value),
                    ),
                    const SharedHeight(SharedDimens.small),
                    // Filtros de status
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildStatusFilter(null, 'Todos'),
                          ...OrderStatus.values.map(
                            (status) => _buildStatusFilter(status, status.label),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<OrdersPageState>(
                  valueListenable: controller.state,
                  builder: (context, state, child) {
                    switch (state) {
                      case OrdersPageState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case OrdersPageState.error:
                        return ValueListenableBuilder<String?>(
                          valueListenable: controller.errorMessage,
                          builder: (context, error, child) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: SharedColors.error,
                                ),
                                const SharedHeight(SharedDimens.medium),
                                Text(
                                  'Erro ao carregar pedidos',
                                  style: SharedTypography.h600,
                                ),
                                const SharedHeight(SharedDimens.small),
                                Text(
                                  error ?? 'Erro desconhecido',
                                  style: SharedTypography.p200,
                                  textAlign: TextAlign.center,
                                ),
                                const SharedHeight(SharedDimens.medium),
                                ElevatedButton(
                                  onPressed: controller.refreshOrders,
                                  child: const Text('Tentar novamente'),
                                ),
                              ],
                            ),
                          ),
                        );
                      case OrdersPageState.empty:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 64,
                                color: SharedColors.textSecondary,
                              ),
                              const SharedHeight(SharedDimens.medium),
                              Text(
                                'Nenhum pedido encontrado',
                                style: SharedTypography.h600,
                              ),
                              const SharedHeight(SharedDimens.small),
                              Text(
                                'Crie seu primeiro pedido',
                                style: SharedTypography.p200,
                              ),
                            ],
                          ),
                        );
                      case OrdersPageState.ready:
                      case OrdersPageState.success:
                        return ValueListenableBuilder<List<OrderEntity>>(
                          valueListenable: controller.orders,
                          builder: (context, orders, child) => RefreshIndicator(
                            onRefresh: controller.refreshOrders,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(SharedDimens.medium),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                final order = orders[index];
                                return _buildOrderCard(order);
                              },
                            ),
                          ),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildStatusFilter(OrderStatus? status, String label) {
    return ValueListenableBuilder<OrderStatus?>(
      valueListenable: controller.selectedStatus,
      builder: (context, selectedStatus, child) {
        final isSelected = selectedStatus == status;
        return Container(
          margin: const EdgeInsets.only(right: SharedDimens.small),
          child: FilterChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (selected) => controller.filterByStatus(
              selected ? status : null,
            ),
            backgroundColor: SharedColors.textFieldBackground,
            selectedColor: SharedColors.brandMain,
            labelStyle: TextStyle(
              color: isSelected ? SharedColors.white : SharedColors.textPrimary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderCard(OrderEntity order) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: SharedDimens.medium),
      child: Padding(
        padding: const EdgeInsets.all(SharedDimens.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedido #${order.id.substring(0, 8)}',
                  style: SharedTypography.h600,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SharedDimens.small,
                    vertical: SharedDimens.tiny,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.status.label,
                    style: SharedTypography.caption.copyWith(
                      color: SharedColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SharedHeight(SharedDimens.small),
            Text(
              order.customerName,
              style: SharedTypography.h500,
            ),
            Text(
              order.customerEmail,
              style: SharedTypography.p200.copyWith(
                color: SharedColors.textSecondary,
              ),
            ),
            const SharedHeight(SharedDimens.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormat.format(order.totalAmount),
                  style: SharedTypography.h600.copyWith(
                    color: SharedColors.brandMain,
                  ),
                ),
                Text(
                  dateFormat.format(order.createdAt),
                  style: SharedTypography.caption.copyWith(
                    color: SharedColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SharedHeight(SharedDimens.small),
            Text(
              '${order.items.length} ${order.items.length == 1 ? 'item' : 'itens'}',
              style: SharedTypography.caption.copyWith(
                color: SharedColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}

