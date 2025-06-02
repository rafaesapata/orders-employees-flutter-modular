import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending('pending', 'Pendente'),
  processing('processing', 'Processando'),
  shipped('shipped', 'Enviado'),
  delivered('delivered', 'Entregue'),
  cancelled('cancelled', 'Cancelado');

  const OrderStatus(this.value, this.label);
  final String value;
  final String label;
}

class OrderEntity extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final List<OrderItemEntity> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;

  const OrderEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerEmail,
        items,
        totalAmount,
        status,
        createdAt,
        updatedAt,
        notes,
      ];

  OrderEntity copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    List<OrderItemEntity>? items,
    double? totalAmount,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }
}

class OrderItemEntity extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [
        id,
        productId,
        productName,
        unitPrice,
        quantity,
        totalPrice,
      ];

  OrderItemEntity copyWith({
    String? id,
    String? productId,
    String? productName,
    double? unitPrice,
    int? quantity,
    double? totalPrice,
  }) {
    return OrderItemEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

