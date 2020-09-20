import 'package:jmorder_app/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/services/api_service.dart';
import 'package:jmorder_app/services/clients_service.dart';
import 'package:jmorder_app/services/kakao_service.dart';
import 'package:jmorder_app/services/orders_service.dart';

class ServiceLocator {
  static void setupLocator() {
    GetIt.I.registerSingletonAsync<ApiService>(() async => ApiService().init());
    GetIt.I.registerSingletonAsync<KakaoService>(
        () async => KakaoService().init());
    GetIt.I.registerSingleton<AuthService>(AuthService());
    GetIt.I.registerSingleton<ClientsService>(ClientsService());
    GetIt.I.registerSingleton<OrdersService>(OrdersService());
  }
}
