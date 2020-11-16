import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'jmo_api_service.dart';

class IntegrationService {
  JmoApiService get _apiService => GetIt.I.get<JmoApiService>();

  Future<bool> checkIntegration(String phone) async {
    try {
      await _apiService
          .getClient()
          .post('/auth/integration', data: {"phone": phone});
      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) return false;
      throw UnexpectedIntegrationException();
    }
  }

  Future<dynamic> performIntegration(String phone, String authDetail) async {
    try {
      var response = await _apiService.getClient().patch('/auth/integration',
          data: {"phone": phone, "authDetail": authDetail});
      return response.data;
    } on DioError {
      throw UnexpectedIntegrationException();
    }
  }
}

class UnexpectedIntegrationException extends DioError {}
