import 'package:dio/dio.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/models/order.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/states/selected_order_state.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';

class OrderService {
  List<Order> orders = [];

  Future<void> fetchOrders() async {
    try {
      var response = await getIt<JmoApiService>().getClient().get('/orders');
      orders = List<Map>.from(response.data)
          .map((Map model) => Order.fromJson(model))
          .toList();
    } on DioError {
      throw OrderFetchFailedException();
    }
  }

  Future<void> createOrder(Client client) async {
    try {
      var response =
          await getIt<JmoApiService>().getClient().post('/orders', data: {
        "user": profileService.state.profile.id,
        "client": client.id,
      });
      final order = Order.fromJson(response.data);
      orders.insert(0, order);
      await selectedOrderState.setState((s) => s.select(order.id));
    } on DioError {
      throw OrderCreateFailedException();
    }
  }

  Future<void> deleteOrder(Order order) async {
    try {
      await getIt<JmoApiService>().getClient().delete("/orders/${order.id}");
    } on DioError {
      throw OrderDeleteFailedException();
    }
  }
}

class OrderFetchFailedException implements Exception {}

class OrderCreateFailedException implements Exception {}

class OrderEditFailedException implements Exception {}

class OrderDeleteFailedException implements Exception {}
