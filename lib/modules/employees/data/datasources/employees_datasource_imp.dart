import 'package:result_dart/result_dart.dart';

import '../../../shared/submodules/rest/data/provider/rest_provider.dart';
import '../../domain/entities/employee_entity.dart';
import '../models/employee_model.dart';
import 'employees_datasource.dart';

class EmployeesDatasourceImp implements EmployeesDatasource {
  final RestProvider _restProvider;

  EmployeesDatasourceImp(this._restProvider);

  @override
  Future<Result<List<EmployeeEntity>, Exception>> getEmployees({
    int page = 1,
    int limit = 20,
    Department? department,
    EmployeeStatus? status,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (department != null) 'department': department.value,
        if (status != null) 'status': status.value,
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final response = await _restProvider.get(
        '/employees',
        queryParameters: queryParams,
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> data = response.data['data'] ?? [];
        final employees = data
            .map((json) => EmployeeModel.fromJson(json).toEntity())
            .toList();
        return Success(employees);
      } else {
        return Failure(Exception('Erro ao buscar funcionários: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<EmployeeEntity, Exception>> getEmployeeById(String id) async {
    try {
      final response = await _restProvider.get('/employees/$id');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final employeeModel = EmployeeModel.fromJson(response.data);
        return Success(employeeModel.toEntity());
      } else {
        return Failure(Exception('Erro ao buscar funcionário: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<EmployeeEntity, Exception>> createEmployee(EmployeeEntity employee) async {
    try {
      final employeeModel = EmployeeModel.fromEntity(employee);
      final response = await _restProvider.post(
        '/employees',
        data: employeeModel.toJson(),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final createdEmployee = EmployeeModel.fromJson(response.data);
        return Success(createdEmployee.toEntity());
      } else {
        return Failure(Exception('Erro ao criar funcionário: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<EmployeeEntity, Exception>> updateEmployee(EmployeeEntity employee) async {
    try {
      final employeeModel = EmployeeModel.fromEntity(employee);
      final response = await _restProvider.put(
        '/employees/${employee.id}',
        data: employeeModel.toJson(),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final updatedEmployee = EmployeeModel.fromJson(response.data);
        return Success(updatedEmployee.toEntity());
      } else {
        return Failure(Exception('Erro ao atualizar funcionário: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<bool, Exception>> deleteEmployee(String id) async {
    try {
      final response = await _restProvider.delete('/employees/$id');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return const Success(true);
      } else {
        return Failure(Exception('Erro ao excluir funcionário: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<EmployeeEntity, Exception>> updateEmployeeStatus(
    String id,
    EmployeeStatus status,
  ) async {
    try {
      final response = await _restProvider.put(
        '/employees/$id/status',
        data: {'status': status.value},
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final updatedEmployee = EmployeeModel.fromJson(response.data);
        return Success(updatedEmployee.toEntity());
      } else {
        return Failure(Exception('Erro ao atualizar status: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<List<Department>, Exception>> getDepartments() async {
    try {
      final response = await _restProvider.get('/employees/departments');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> data = response.data['data'] ?? [];
        final departments = data
            .map((item) => Department.values.firstWhere(
                  (d) => d.value == item['value'],
                  orElse: () => Department.administration,
                ))
            .toList();
        return Success(departments);
      } else {
        return Failure(Exception('Erro ao buscar departamentos: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<List<EmployeePosition>, Exception>> getPositionsByDepartment(
    Department department,
  ) async {
    try {
      final response = await _restProvider.get(
        '/employees/positions',
        queryParameters: {'department': department.value},
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> data = response.data['data'] ?? [];
        final positions = data
            .map((item) => EmployeePosition.values.firstWhere(
                  (p) => p.value == item['value'],
                  orElse: () => EmployeePosition.assistant,
                ))
            .toList();
        return Success(positions);
      } else {
        return Failure(Exception('Erro ao buscar cargos: ${response.statusMessage}'));
      }
    } catch (e) {
      return Failure(Exception('Erro de conexão: $e'));
    }
  }

  @override
  Future<Result<Map<String, dynamic>, Exception>> getEmployeesStats() async {
    try {
      final response = await _restProvider.get('/employees/stats');

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

