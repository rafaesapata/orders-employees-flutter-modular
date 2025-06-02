import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../shared/presentation/widgets/shared_height.dart';
import '../../domain/entities/employee_entity.dart';
import '../controllers/employees_controller.dart';

class EmployeesListPage extends StatefulWidget {
  const EmployeesListPage({super.key});

  @override
  State<EmployeesListPage> createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  final EmployeesController controller = Modular.get();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.initialize());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Funcionários'),
            backgroundColor: SharedColors.brandMain,
            foregroundColor: SharedColors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // TODO: Navegar para tela de criação de funcionário
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(SharedDimens.medium),
                color: SharedColors.textFieldBackground,
                child: Column(
                  children: [
                    // Campo de busca
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar funcionários...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: SharedColors.white,
                      ),
                      onChanged: (value) => controller.searchEmployees(value),
                    ),
                    const SharedHeight(SharedDimens.small),
                    // Filtros de departamento
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildDepartmentFilter(null, 'Todos'),
                          ...Department.values.map(
                            (dept) => _buildDepartmentFilter(dept, dept.label),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<EmployeesPageState>(
                  valueListenable: controller.state,
                  builder: (context, state, child) {
                    switch (state) {
                      case EmployeesPageState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case EmployeesPageState.error:
                        return ValueListenableBuilder<String?>(
                          valueListenable: controller.errorMessage,
                          builder: (context, error, child) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: SharedColors.error,
                                ),
                                const SharedHeight(SharedDimens.medium),
                                Text(
                                  'Erro ao carregar funcionários',
                                  style: SharedTypography.h600,
                                ),
                                const SharedHeight(SharedDimens.small),
                                Text(
                                  error ?? 'Erro desconhecido',
                                  style: SharedTypography.p200,
                                  textAlign: TextAlign.center,
                                ),
                                const SharedHeight(SharedDimens.medium),
                                ElevatedButton(
                                  onPressed: controller.refreshEmployees,
                                  child: const Text('Tentar novamente'),
                                ),
                              ],
                            ),
                          ),
                        );
                      case EmployeesPageState.empty:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 64,
                                color: SharedColors.textSecondary,
                              ),
                              const SharedHeight(SharedDimens.medium),
                              Text(
                                'Nenhum funcionário encontrado',
                                style: SharedTypography.h600,
                              ),
                              const SharedHeight(SharedDimens.small),
                              Text(
                                'Cadastre o primeiro funcionário',
                                style: SharedTypography.p200,
                              ),
                            ],
                          ),
                        );
                      case EmployeesPageState.ready:
                      case EmployeesPageState.success:
                        return ValueListenableBuilder<List<EmployeeEntity>>(
                          valueListenable: controller.employees,
                          builder: (context, employees, child) => RefreshIndicator(
                            onRefresh: controller.refreshEmployees,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(SharedDimens.medium),
                              itemCount: employees.length,
                              itemBuilder: (context, index) {
                                final employee = employees[index];
                                return _buildEmployeeCard(employee);
                              },
                            ),
                          ),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildDepartmentFilter(Department? department, String label) {
    return ValueListenableBuilder<Department?>(
      valueListenable: controller.selectedDepartment,
      builder: (context, selectedDepartment, child) {
        final isSelected = selectedDepartment == department;
        return Container(
          margin: const EdgeInsets.only(right: SharedDimens.small),
          child: FilterChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (selected) => controller.filterByDepartment(
              selected ? department : null,
            ),
            backgroundColor: SharedColors.textFieldBackground,
            selectedColor: SharedColors.brandMain,
            labelStyle: TextStyle(
              color: isSelected ? SharedColors.white : SharedColors.textPrimary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmployeeCard(EmployeeEntity employee) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: SharedDimens.medium),
      child: Padding(
        padding: const EdgeInsets.all(SharedDimens.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    employee.name,
                    style: SharedTypography.h600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SharedDimens.small,
                    vertical: SharedDimens.tiny,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(employee.status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    employee.status.label,
                    style: SharedTypography.caption.copyWith(
                      color: SharedColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SharedHeight(SharedDimens.small),
            Text(
              employee.email,
              style: SharedTypography.p200.copyWith(
                color: SharedColors.textSecondary,
              ),
            ),
            Text(
              employee.phone,
              style: SharedTypography.p200.copyWith(
                color: SharedColors.textSecondary,
              ),
            ),
            const SharedHeight(SharedDimens.small),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.department.label,
                        style: SharedTypography.h500,
                      ),
                      Text(
                        employee.position.label,
                        style: SharedTypography.caption.copyWith(
                          color: SharedColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currencyFormat.format(employee.salary),
                      style: SharedTypography.h600.copyWith(
                        color: SharedColors.brandMain,
                      ),
                    ),
                    Text(
                      'Desde ${dateFormat.format(employee.hireDate)}',
                      style: SharedTypography.caption.copyWith(
                        color: SharedColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return Colors.green;
      case EmployeeStatus.inactive:
        return Colors.orange;
      case EmployeeStatus.suspended:
        return Colors.red;
      case EmployeeStatus.terminated:
        return Colors.grey;
    }
  }
}

