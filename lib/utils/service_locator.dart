import 'package:get_it/get_it.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/services/clients_service.dart';
import 'package:jmorder_app/services/orders_service.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setupLocator() {
    getIt.registerSingletonAsync<JmoApiService>(
        () async => JmoApiService()..init());
    // getIt.registerLazySingleton<FirebaseDynamicService>(
    //     () => FirebaseDynamicService());
    // getIt.registerSingleton<VerificationService>(VerificationService());
    getIt.registerSingleton<ClientsService>(ClientsService());
    getIt.registerSingleton<OrdersService>(OrdersService());
  }
}
