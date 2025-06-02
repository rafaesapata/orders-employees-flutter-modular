import 'package:result_dart/result_dart.dart';

import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employees_repository.dart';
import '../datasources/employees_datasource.dart';

class EmployeesRepositoryImp implements EmployeesRepository {
  final EmployeesDatasource _datasource;

  EmployeesRepositoryImp(this._datasource);

  @override
  Future<Result<List<EmployeeEntity>, Exception>> getEmployees({
    int page = 1,
    int limit = 20,
    Department? department,
    EmployeeStatus? status,
    String? search,
  }) async {
    return await _datasource.getEmployees(
      page: page,
      limit: limit,
      department: department,
      status: status,
      search: search,
    );
  }

  @override
  Future<Result<EmployeeEntity, Exception>> getEmployeeById(String id) async {
    return await _datasource.getEmployeeById(id);
  }

  @override
  Future<Result<EmployeeEntity, Exception>> createEmployee(EmployeeEntity employee) async {
    return await _datasource.createEmployee(employee);
  }

  @override
  Future<Result<EmployeeEntity, Exception>> updateEmployee(EmployeeEntity employee) async {
    return await _datasource.updateEmployee(employee);
  }

  @override
  Future<Result<bool, Exception>> deleteEmployee(String id) async {
    return await _datasource.deleteEmployee(id);
  }

  @override
  Future<Result<EmployeeEntity, Exception>> updateEmployeeStatus(
    String id,
    EmployeeStatus status,
  ) async {
    return await _datasource.updateEmployeeStatus(id, status);
  }

  @override
  Future<Result<List<Department>, Exception>> getDepartments() async {
    return await _datasource.getDepartments();
  }

  @override
  Future<Result<List<EmployeePosition>, Exception>> getPositionsByDepartment(
    Department department,
  ) async {
    return await _datasource.getPositionsByDepartment(department);
  }

  @override
  Future<Result<Map<String, dynamic>, Exception>> getEmployeesStats() async {
    return await _datasource.getEmployeesStats();
  }
}

