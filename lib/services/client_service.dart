import 'package:dio/dio.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';

class ClientService {
  List<Client> clients = [];

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
      clients.add(Client.fromJson(response.data));
    } on DioError {
      throw ClientAddFailedException();
    }
  }

  Future<List<Client>> searchClient(String query) async {
    try {
      var response = await getIt<JmoApiService>().getClient().get(
        "/clients/search",
        queryParameters: {"q": query},
      );
      return List<Map>.from(response.data)
          .map((Map model) => Client.fromJson(model))
          .toList();
    } on DioError {
      return [];
    }
  }

  Future<void> deleteClient(Client client) async {
    try {
      await getIt<JmoApiService>().getClient().delete("/clients/${client.id}");
      clients.remove(client);
    } on DioError {
      throw ClientDeleteFailedException();
    }
  }
}

class ClientFetchFailedException implements Exception {}

class ClientAddFailedException implements Exception {}

class ClientEditFailedException implements Exception {}

class ClientDeleteFailedException implements Exception {}
