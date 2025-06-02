import 'package:equatable/equatable.dart';

enum EmployeeStatus {
  active('active', 'Ativo'),
  inactive('inactive', 'Inativo'),
  suspended('suspended', 'Suspenso'),
  terminated('terminated', 'Demitido');

  const EmployeeStatus(this.value, this.label);
  final String value;
  final String label;
}

enum EmployeePosition {
  admin('admin', 'Administrador'),
  manager('manager', 'Gerente'),
  supervisor('supervisor', 'Supervisor'),
  analyst('analyst', 'Analista'),
  assistant('assistant', 'Assistente'),
  intern('intern', 'Estagiário');

  const EmployeePosition(this.value, this.label);
  final String value;
  final String label;
}

enum Department {
  administration('administration', 'Administração'),
  sales('sales', 'Vendas'),
  marketing('marketing', 'Marketing'),
  finance('finance', 'Financeiro'),
  hr('hr', 'Recursos Humanos'),
  it('it', 'Tecnologia da Informação'),
  operations('operations', 'Operações'),
  logistics('logistics', 'Logística');

  const Department(this.value, this.label);
  final String value;
  final String label;
}

class EmployeeEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final Department department;
  final EmployeePosition position;
  final EmployeeStatus status;
  final double salary;
  final DateTime hireDate;
  final DateTime? terminationDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? address;
  final String? notes;

  const EmployeeEntity({
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

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        cpf,
        department,
        position,
        status,
        salary,
        hireDate,
        terminationDate,
        createdAt,
        updatedAt,
        address,
        notes,
      ];

  EmployeeEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? cpf,
    Department? department,
    EmployeePosition? position,
    EmployeeStatus? status,
    double? salary,
    DateTime? hireDate,
    DateTime? terminationDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    String? notes,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf,
      department: department ?? this.department,
      position: position ?? this.position,
      status: status ?? this.status,
      salary: salary ?? this.salary,
      hireDate: hireDate ?? this.hireDate,
      terminationDate: terminationDate ?? this.terminationDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
      notes: notes ?? this.notes,
    );
  }
}

