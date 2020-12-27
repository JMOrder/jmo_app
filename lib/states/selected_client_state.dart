import 'package:dio/dio.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';

class SelectedClientState {
  Client model;

  Future<void> select(int clientId) async {
    try {
      var response =
          await getIt<JmoApiService>().getClient().get("/clients/$clientId");
      model = Client.fromJson(response.data);
    } on DioError {
      throw ClientNotFoundException();
    }
  }

  void unselect() {
    model = null;
  }

  Future<void> delete() async {
    await getIt<JmoApiService>().getClient().delete("/clients/${model.id}");
  }

  Future<void> addItem(Item item) async {
    try {
      var response = await getIt<JmoApiService>().getClient().post(
            "/clients/${model.id}/items",
            data: item.toJson(),
          );
      model.items.add(Item.fromJson(response.data));
    } on DioError {
      throw ItemAddFailedException();
    }
  }

  Future<void> editItem(Item item) async {
    try {
      var response = await getIt<JmoApiService>().getClient().put(
            "/clients/${model.id}/items/${item.id}",
            data: item.toJson(),
          );
      final index = model.items.indexOf(item);
      model.items[index] = Item.fromJson(response.data);
    } on DioError {
      throw ItemEditFailedException();
    }
  }

  Future<void> deleteItem(Item item) async {
    try {
      await getIt<JmoApiService>()
          .getClient()
          .delete("/clients/${model.id}/items/${item.id}");
      model.items.remove(item);
    } on DioError {
      throw ItemDeleteFailedException();
    }
  }
}

class ClientNotFoundException implements Exception {}

class ItemAddFailedException implements Exception {}

class ItemEditFailedException implements Exception {}

class ItemDeleteFailedException implements Exception {}
