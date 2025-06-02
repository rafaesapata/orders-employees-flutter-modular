import '../../domain/entities/order_entity.dart';

class OrderModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;

  OrderModel({
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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerEmail: json['customer_email'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'items': items.map((item) => item.toJson()).toList(),
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'notes': notes,
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      customerId: entity.customerId,
      customerName: entity.customerName,
      customerEmail: entity.customerEmail,
      items: entity.items
          .map((item) => OrderItemModel.fromEntity(item))
          .toList(),
      totalAmount: entity.totalAmount,
      status: entity.status.value,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      notes: entity.notes,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      customerId: customerId,
      customerName: customerName,
      customerEmail: customerEmail,
      items: items.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      status: OrderStatus.values.firstWhere(
        (s) => s.value == status,
        orElse: () => OrderStatus.pending,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
      notes: notes,
    );
  }
}

class OrderItemModel {
  final String id;
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      totalPrice: (json['total_price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'unit_price': unitPrice,
      'quantity': quantity,
      'total_price': totalPrice,
    };
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      id: entity.id,
      productId: entity.productId,
      productName: entity.productName,
      unitPrice: entity.unitPrice,
      quantity: entity.quantity,
      totalPrice: entity.totalPrice,
    );
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      productId: productId,
      productName: productName,
      unitPrice: unitPrice,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }
}

