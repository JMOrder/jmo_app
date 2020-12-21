import 'package:dio/dio.dart';
import 'package:jmorder_app/models/profile.dart';

import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/service_locator.dart';

class ProfileService {
  Profile profile;

  String get fullName => profile.fullName;

  Future<void> fetchProfile() async {
    try {
      var response = await getIt<JmoApiService>().getClient().get("/profile");
      profile = Profile.fromJson(response.data);
    } on DioError {
      throw ProfileFetchFailedException();
    }
  }
}

class ProfileFetchFailedException implements Exception {}
