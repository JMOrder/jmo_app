import 'package:dio/dio.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/service_locator.dart';

class ClientService {
  List<Client> clients = [];

  ClientService();

  Future<void> fetchClients() async {
    try {
      var response = await getIt<JmoApiService>().getClient().get('/clients');
      clients = List.from(List<Map>.from(response.data)
          .map((Map model) => Client.fromJson(model)));
    } on DioError {
      throw ClientFetchFailedException();
    }
  }

  Future<void> addClient(Client client) async {
    try {
      var response = await getIt<JmoApiService>()
          .getClient()
          .post('/clients', data: client.toJson());
      this.clients.add(Client.fromJson(response.data));
    } on DioError {
      throw ClientAddFailedException();
    }
  }

  Future<void> deleteClient(Client client) async {
    try {
      await getIt<JmoApiService>().getClient().delete("/clients/${client.id}");
    } on DioError {
      throw ClientDeleteFailedException();
    }
  }
}

class ClientFetchFailedException implements Exception {}

class ClientAddFailedException implements Exception {}

class ClientDeleteFailedException implements Exception {}
