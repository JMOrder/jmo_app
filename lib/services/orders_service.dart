import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/order.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/services/auth_service.dart';

import 'exceptions/common_http_exception.dart';

class OrdersService {
  JmoApiService get _apiService => GetIt.I.get<JmoApiService>();
  List<Order> orders = [];

  Future<List<Order>> fetchOrders() async {
    try {
      var response = await _apiService.getClient().get('/orders');
      this.orders = List<Map>.from(response.data)
          .map((Map model) => Order.fromJson(model))
          .toList();
      return this.orders;
    } on DioError catch (e) {
      if (e.response != null) throw FetchFailedException();
      throw UnexpectedOrdersException();
    }
  }

  Future<Order> fetchOrderById(int id) async {
    try {
      var response = await _apiService.getClient().get("/orders/$id");
      return Order.fromJson(response.data);
    } on DioError {
      throw new UnexpectedOrdersException();
    }
  }

  Future<Order> createOrder(Order order) async {
    try {
      var response = await _apiService.getClient().post('/orders', data: {
        "user": GetIt.I.get<AuthService>().profile.id,
        "client": order.client.id,
      });
      this.orders.insert(0, Order.fromJson(response.data));
      return Order.fromJson(response.data);
    } on DioError {
      throw UnexpectedOrdersException();
    }
  }

  Future<Order> updateOrder(Order order) async {
    try {
      var response =
          await _apiService.getClient().put("/orders/${order.id}", data: order);
      return Order.fromJson(response.data);
    } on DioError {
      throw UnexpectedOrdersException();
    }
  }

  Future<void> deleteOrder(Order order) async {
    try {
      await _apiService.getClient().delete("/orders/${order.id}");
    } on DioError catch (e) {
      if (e.response != null) throw FetchFailedException();
      throw UnexpectedOrdersException();
    }
  }
}

class UnexpectedOrdersException extends DioError {}
