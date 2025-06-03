import 'package:flutter_modular/flutter_modular.dart';

import '../shared/domain/bases/shared_base_module.dart';
import '../shared/submodules/rest/rest_module.dart';
import 'data/datasources/employees_datasource.dart';
import 'data/datasources/employees_datasource_imp.dart';
import 'data/repositories/employees_repository_imp.dart';
import 'domain/repositories/employees_repository.dart';
import 'domain/usecases/create_employee_usecase.dart';
import 'domain/usecases/get_employees_usecase.dart';
import 'employees_routes.dart';
import 'presentation/controllers/employees_controller.dart';
import 'presentation/pages/employees_list_page.dart';

class EmployeesModule extends SharedBaseModule {
  @override
  List<Module> get imports => [
        RestModule(),
      ];

  @override
  void binds(Injector i) {
    // Datasources
    i.addLazySingleton<EmployeesDatasource>(EmployeesDatasourceImp.new);

    // Repositories
    i.addLazySingleton<EmployeesRepository>(EmployeesRepositoryImp.new);

    // Use Cases
    i.addLazySingleton<GetEmployeesUseCase>(GetEmployeesUseCaseImp.new);
    i.addLazySingleton<CreateEmployeeUseCase>(CreateEmployeeUseCaseImp.new);

    // Controllers
    i.add<EmployeesController>(EmployeesControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      EmployeesRoutes.employeesList,
      child: (_) => const EmployeesListPage(),
    );

    super.routes(r);
  }
}
