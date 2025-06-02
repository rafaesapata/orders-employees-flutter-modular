import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/employee_entity.dart';
import '../repositories/employees_repository.dart';

abstract class CreateEmployeeUseCase {
  Future<Result<EmployeeEntity, Exception>> call(EmployeeEntity employee);
}

class CreateEmployeeUseCaseImp implements CreateEmployeeUseCase {
  final EmployeesRepository _repository;

  CreateEmployeeUseCaseImp(this._repository);

  @override
  Future<Result<EmployeeEntity, Exception>> call(EmployeeEntity employee) async {
    // Validações de negócio
    if (employee.name.trim().isEmpty) {
      return Failure(Exception('Nome do funcionário é obrigatório'));
    }

    if (employee.email.trim().isEmpty) {
      return Failure(Exception('Email do funcionário é obrigatório'));
    }

    // Validar email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(employee.email)) {
      return Failure(Exception('Email do funcionário inválido'));
    }

    if (employee.phone.trim().isEmpty) {
      return Failure(Exception('Telefone do funcionário é obrigatório'));
    }

    if (employee.cpf.trim().isEmpty) {
      return Failure(Exception('CPF do funcionário é obrigatório'));
    }

    // Validar CPF
    if (!CPFValidator.isValid(employee.cpf)) {
      return Failure(Exception('CPF inválido'));
    }

    if (employee.salary <= 0) {
      return Failure(Exception('Salário deve ser maior que zero'));
    }

    // Validar data de contratação
    if (employee.hireDate.isAfter(DateTime.now())) {
      return Failure(Exception('Data de contratação não pode ser futura'));
    }

    return await _repository.createEmployee(employee);
  }
}

