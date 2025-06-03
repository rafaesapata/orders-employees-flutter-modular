import 'package:flutter/material.dart';

import '../../domain/entities/employee_entity.dart';
import '../../domain/usecases/create_employee_usecase.dart';
import '../../domain/usecases/get_employees_usecase.dart';

enum EmployeesPageState { loading, ready, error, success, empty }

abstract class EmployeesController extends ChangeNotifier {
  ValueNotifier<EmployeesPageState> get state;
  ValueNotifier<List<EmployeeEntity>> get employees;
  ValueNotifier<String?> get errorMessage;
  ValueNotifier<bool> get isLoading;
  ValueNotifier<Department?> get selectedDepartment;
  ValueNotifier<EmployeeStatus?> get selectedStatus;
  ValueNotifier<String> get searchQuery;

  Future<void> initialize();
  Future<void> loadEmployees();
  Future<void> refreshEmployees();
  Future<void> filterByDepartment(Department? department);
  Future<void> filterByStatus(EmployeeStatus? status);
  Future<void> searchEmployees(String query);
  Future<void> createEmployee(EmployeeEntity employee);
  void clearError();
}

class EmployeesControllerImp extends EmployeesController {
  final GetEmployeesUseCase _getEmployeesUseCase;
  final CreateEmployeeUseCase _createEmployeeUseCase;

  @override
  final state = ValueNotifier<EmployeesPageState>(EmployeesPageState.loading);

  @override
  final employees = ValueNotifier<List<EmployeeEntity>>([]);

  @override
  final errorMessage = ValueNotifier<String?>(null);

  @override
  final isLoading = ValueNotifier<bool>(false);

  @override
  final selectedDepartment = ValueNotifier<Department?>(null);

  @override
  final selectedStatus = ValueNotifier<EmployeeStatus?>(null);

  @override
  final searchQuery = ValueNotifier<String>('');

  EmployeesControllerImp({
    required GetEmployeesUseCase getEmployeesUseCase,
    required CreateEmployeeUseCase createEmployeeUseCase,
  })  : _getEmployeesUseCase = getEmployeesUseCase,
        _createEmployeeUseCase = createEmployeeUseCase;

  @override
  Future<void> initialize() async {
    await loadEmployees();
  }

  @override
  Future<void> loadEmployees() async {
    state.value = EmployeesPageState.loading;
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _getEmployeesUseCase(
      department: selectedDepartment.value,
      status: selectedStatus.value,
      search: searchQuery.value.isEmpty ? null : searchQuery.value,
    );

    result.fold(
      (success) {
        employees.value = success;
        state.value = success.isEmpty
            ? EmployeesPageState.empty
            : EmployeesPageState.ready;
      },
      (error) {
        errorMessage.value = error.toString();
        state.value = EmployeesPageState.error;
      },
    );

    isLoading.value = false;
    notifyListeners();
  }

  @override
  Future<void> refreshEmployees() async {
    await loadEmployees();
  }

  @override
  Future<void> filterByDepartment(Department? department) async {
    selectedDepartment.value = department;
    await loadEmployees();
  }

  @override
  Future<void> filterByStatus(EmployeeStatus? status) async {
    selectedStatus.value = status;
    await loadEmployees();
  }

  @override
  Future<void> searchEmployees(String query) async {
    searchQuery.value = query;
    await loadEmployees();
  }

  @override
  Future<void> createEmployee(EmployeeEntity employee) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _createEmployeeUseCase(employee);

    result.fold(
      (success) {
        // Adicionar o novo funcionário à lista
        employees.value = [success, ...employees.value];
        state.value = EmployeesPageState.success;
      },
      (error) {
        errorMessage.value = error.toString();
        state.value = EmployeesPageState.error;
      },
    );

    isLoading.value = false;
    notifyListeners();
  }

  @override
  void clearError() {
    errorMessage.value = null;
    if (state.value == EmployeesPageState.error) {
      state.value = employees.value.isEmpty
          ? EmployeesPageState.empty
          : EmployeesPageState.ready;
    }
    notifyListeners();
  }
}
