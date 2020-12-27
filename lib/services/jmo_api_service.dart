import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:jmorder_app/services/jmo_api_service/jmo_api_serivce_interceptor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:jmorder_app/services/exceptions/unsupported_os_exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton()
class JmoApiService {
  final Dio _client = new Dio();
  CookieJar _cookieJar;

  JmoApiService() {
    if (Platform.isAndroid)
      _client.options.baseUrl = "http://10.0.1.10:8080";
    else if (Platform.isIOS)
      _client.options.baseUrl = "http://localhost:8080";
    else
      throw UnsupportedOSException(Platform.operatingSystem);

    _client.options.connectTimeout = 5000;
    _client.options.receiveTimeout = 5000;
    _client.options.headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  void setAuthorizationHeader(String authorization) {
    _client.options.headers["authorization"] = authorization;
  }

  void clearAuthorizationHeader() {
    _client.options.headers["authorization"] = "";
  }

  @factoryMethod
  static Future<JmoApiService> create() async {
    final instance = JmoApiService();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    instance._cookieJar = PersistCookieJar(
      dir: appDocDir.path + "/.cookies/",
    );
    instance._client
      ..interceptors.addAll(
        [
          CookieManager(
            instance._cookieJar,
          ),
          PrettyDioLogger(
            requestHeader: false,
            requestBody: false,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
          JmoApiServiceInterceptor(client: instance._client),
        ],
      );
    return instance;
  }

  Dio getClient() {
    return this._client;
  }

  CookieJar getCookieJar() {
    return this._cookieJar;
  }
}
