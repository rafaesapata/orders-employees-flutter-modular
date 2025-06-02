import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import '../shared/domain/bases/shared_base_module.dart';
import '../shared/submodules/rest/rest_module.dart';
import 'data/datasources/orders_datasource.dart';
import 'data/datasources/orders_datasource_imp.dart';
import 'data/repositories/orders_repository_imp.dart';
import 'domain/repositories/orders_repository.dart';
import 'domain/usecases/create_order_usecase.dart';
import 'domain/usecases/get_orders_usecase.dart';
import 'orders_routes.dart';
import 'presentation/controllers/orders_controller.dart';
import 'presentation/pages/orders_list_page.dart';

class OrdersModule extends SharedBaseModule {
  @override
  List<Module> get imports => [
        RestModule(),
      ];

  @override
  void binds(Injector i) {
    // Datasources
    i.addLazySingleton<OrdersDatasource>(OrdersDatasourceImp.new);

    // Repositories
    i.addLazySingleton<OrdersRepository>(OrdersRepositoryImp.new);

    // Use Cases
    i.addLazySingleton<GetOrdersUseCase>(GetOrdersUseCaseImp.new);
    i.addLazySingleton<CreateOrderUseCase>(CreateOrderUseCaseImp.new);

    // Controllers
    i.add<OrdersController>(OrdersControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      OrdersRoutes.ordersList,
      child: (_) => const OrdersListPage(),
    );
    
    super.routes(r);
  }
}

