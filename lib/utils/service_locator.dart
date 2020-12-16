import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/services/firebase_dynamic_link_service.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/services/clients_service.dart';
import 'package:jmorder_app/services/integration_service.dart';
import 'package:jmorder_app/services/orders_service.dart';

class ServiceLocator {
  static void setupLocator() {
    GetIt.I.registerSingletonAsync<JmoApiService>(
        () async => JmoApiService()..init());
    GetIt.I
        .registerSingletonAsync<AuthService>(() async => AuthService()..init());
    // GetIt.I.registerLazySingleton<FirebaseDynamicService>(
    //     () => FirebaseDynamicService());
    GetIt.I.registerSingleton<VerificationService>(VerificationService());
    GetIt.I.registerSingleton<ClientsService>(ClientsService());
    GetIt.I.registerSingleton<OrdersService>(OrdersService());
  }
}
