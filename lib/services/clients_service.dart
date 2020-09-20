import 'package:dio/dio.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/services/api_service.dart';

import 'exceptions/common_http_exception.dart';

class ClientsService {
  ApiService get _apiService => GetIt.I.get<ApiService>();
  List<Client> _clients = [];

  List<Client> get clients => List.unmodifiable(_clients);

  Future<List<Client>> fetchClients() async {
    try {
      var response = await _apiService.getClient().get('/clients');
      this._clients = List.from(List<Map>.from(response.data)
          .map((Map model) => Client.fromJson(model)));
      return this._clients;
    } on DioError catch (e) {
      if (e.response != null) throw FetchFailedException();
      throw UnexpectedClientsException();
    }
  }

  Future<Client> fetchClientById(int id) async {
    try {
      var response = await _apiService.getClient().get("/clients/$id");
      return Client.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) throw FetchFailedException();
      throw UnexpectedClientsException();
    }
  }

  Future<void> deleteClient(Client client) async {
    try {
      await _apiService.getClient().delete("/clients/${client.id}");
    } on DioError {
      throw UnexpectedClientsException();
    }
  }

  Future<Client> createClient({@required Client client}) async {
    try {
      var response =
          await _apiService.getClient().post('/clients', data: client.toJson());
      var createdClient = Client.fromJson(response.data);
      this._clients.add(Client.fromJson(response.data));
      return createdClient;
    } on DioError {
      throw UnexpectedClientsException();
    }
  }

  Future<Item> addItem({@required Client client, @required Item item}) async {
    try {
      var response = await _apiService.getClient().post(
            "/clients/${client.id}/items",
            data: item.toJson(),
          );
      item = Item.fromJson(response.data);
      client.items.add(item);
      return item;
    } on DioError {
      throw UnexpectedClientsException();
    }
  }

  Future<Item> editItem({@required Client client, @required Item item}) async {
    try {
      var response = await _apiService.getClient().put(
            "/clients/${client.id}/items/${item.id}",
            data: item.toJson(),
          );
      return Item.fromJson(response.data);
    } on DioError {
      throw UnexpectedClientsException();
    }
  }

  Future<void> deleteItem(
      {@required Client client, @required Item item}) async {
    try {
      await _apiService
          .getClient()
          .delete("/clients/${client.id}/items/${item.id}");
      client.items.removeWhere((targetItem) => targetItem.id == item.id);
    } on DioError {
      throw UnexpectedClientsException();
    }
  }
}

class UnexpectedClientsException extends DioError {}
