import 'package:dartz/dartz.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/employee_entity.dart';

abstract class EmployeesRepository {
  Future<Result<List<EmployeeEntity>, Exception>> getEmployees({
    int page = 1,
    int limit = 20,
    Department? department,
    EmployeeStatus? status,
    String? search,
  });

  Future<Result<EmployeeEntity, Exception>> getEmployeeById(String id);

  Future<Result<EmployeeEntity, Exception>> createEmployee(EmployeeEntity employee);

  Future<Result<EmployeeEntity, Exception>> updateEmployee(EmployeeEntity employee);

  Future<Result<bool, Exception>> deleteEmployee(String id);

  Future<Result<EmployeeEntity, Exception>> updateEmployeeStatus(
    String id,
    EmployeeStatus status,
  );

  Future<Result<List<Department>, Exception>> getDepartments();

  Future<Result<List<EmployeePosition>, Exception>> getPositionsByDepartment(
    Department department,
  );

  Future<Result<Map<String, dynamic>, Exception>> getEmployeesStats();
}

