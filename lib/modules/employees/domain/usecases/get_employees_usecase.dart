import 'package:result_dart/result_dart.dart';

import '../entities/employee_entity.dart';
import '../repositories/employees_repository.dart';

abstract class GetEmployeesUseCase {
  Future<Result<List<EmployeeEntity>, Exception>> call({
    int page = 1,
    int limit = 20,
    Department? department,
    EmployeeStatus? status,
    String? search,
  });
}

class GetEmployeesUseCaseImp implements GetEmployeesUseCase {
  final EmployeesRepository _repository;

  GetEmployeesUseCaseImp(this._repository);

  @override
  Future<Result<List<EmployeeEntity>, Exception>> call({
    int page = 1,
    int limit = 20,
    Department? department,
    EmployeeStatus? status,
    String? search,
  }) async {
    return await _repository.getEmployees(
      page: page,
      limit: limit,
      department: department,
      status: status,
      search: search,
    );
  }
}

