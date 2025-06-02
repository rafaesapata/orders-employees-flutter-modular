import '../../domain/entities/employee_entity.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final String department;
  final String position;
  final String status;
  final double salary;
  final DateTime hireDate;
  final DateTime? terminationDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? address;
  final String? notes;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.department,
    required this.position,
    required this.status,
    required this.salary,
    required this.hireDate,
    this.terminationDate,
    required this.createdAt,
    this.updatedAt,
    this.address,
    this.notes,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      cpf: json['cpf'] ?? '',
      department: json['department'] ?? 'administration',
      position: json['position'] ?? 'assistant',
      status: json['status'] ?? 'active',
      salary: (json['salary'] ?? 0).toDouble(),
      hireDate: DateTime.parse(json['hire_date'] ?? DateTime.now().toIso8601String()),
      terminationDate: json['termination_date'] != null 
          ? DateTime.parse(json['termination_date']) 
          : null,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      address: json['address'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'department': department,
      'position': position,
      'status': status,
      'salary': salary,
      'hire_date': hireDate.toIso8601String(),
      'termination_date': terminationDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'address': address,
      'notes': notes,
    };
  }

  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      cpf: entity.cpf,
      department: entity.department.value,
      position: entity.position.value,
      status: entity.status.value,
      salary: entity.salary,
      hireDate: entity.hireDate,
      terminationDate: entity.terminationDate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      address: entity.address,
      notes: entity.notes,
    );
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      cpf: cpf,
      department: Department.values.firstWhere(
        (d) => d.value == department,
        orElse: () => Department.administration,
      ),
      position: EmployeePosition.values.firstWhere(
        (p) => p.value == position,
        orElse: () => EmployeePosition.assistant,
      ),
      status: EmployeeStatus.values.firstWhere(
        (s) => s.value == status,
        orElse: () => EmployeeStatus.active,
      ),
      salary: salary,
      hireDate: hireDate,
      terminationDate: terminationDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      address: address,
      notes: notes,
    );
  }
}

