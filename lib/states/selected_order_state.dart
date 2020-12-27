import 'package:dio/dio.dart';
import 'package:jmorder_app/models/order.dart';
import 'package:jmorder_app/models/order_item.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';

class SelectedOrderState {
  Order model;
  Future<void> select(int orderId) async {
    try {
      var response =
          await getIt<JmoApiService>().getClient().get("/orders/$orderId");
      model = Order.fromJson(response.data);
    } on DioError {
      throw OrderNotFoundException();
    }
  }

  Future<void> updateOrder() async {
    try {
      var response = await getIt<JmoApiService>()
          .getClient()
          .put("/orders/${model.id}", data: model);
      model = Order.fromJson(response.data);
    } on DioError {
      throw OrderUpdateFailedException();
    }
  }

  // TODO: JMO-23: When Orphaned row issue is resolved, this can be deleted
  Future<void> addOrderItem(OrderItem orderItem) async {
    try {
      var response = await getIt<JmoApiService>()
          .getClient()
          .post("/orders/${model.id}/order-items", data: orderItem);
      orderItem = OrderItem.fromJson(response.data);
      model.orderItems.add(orderItem);
    } on DioError {
      throw OrderItemAddFailedException();
    }
  }

  Future<void> removeOrderItem(OrderItem orderItem) async {
    try {
      await getIt<JmoApiService>()
          .getClient()
          .delete("/orders/${model.id}/order-items/${orderItem.id}");
      model.orderItems.removeWhere((element) => element.id == orderItem.id);
    } on DioError {
      throw OrderItemDeleteFailedException();
    }
  }
}

class OrderNotFoundException implements Exception {}

class OrderUpdateFailedException implements Exception {}

class OrderItemAddFailedException implements Exception {}

class OrderItemDeleteFailedException implements Exception {}
