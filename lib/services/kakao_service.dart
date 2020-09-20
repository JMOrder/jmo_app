import 'dart:developer';

import 'package:kakao_flutter_sdk/link.dart';

class KakaoService {
  bool _isKakaoInstalled = false;

  Future<KakaoService> init() async {
    KakaoContext.clientId = "13e09b15ed7f5e5d27ccba109cf1bbc2";
    _isKakaoInstalled = await isKakaoTalkInstalled();
    log('kakao Install : ' + _isKakaoInstalled.toString());
    return this;
  }
}
