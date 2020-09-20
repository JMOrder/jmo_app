import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:logger/logger.dart';

class KakaoService {
  bool _isKakaoInstalled = false;
  Logger _logger = Logger();

  bool get isKakaoInstalled => _isKakaoInstalled;

  Future<KakaoService> init() async {
    KakaoContext.clientId = "13e09b15ed7f5e5d27ccba109cf1bbc2";
    _isKakaoInstalled = await isKakaoTalkInstalled();
    _logger.d('kakao Installation status : ' + _isKakaoInstalled.toString());
    return this;
  }

  void loginButtonClicked() async {
    try {
      final authCode = _isKakaoInstalled
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();
      _logger.d(authCode);
      AccessTokenResponse token =
          await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
    } on KakaoAuthException catch (e) {
      _logger.e(e);
      // some error happened during the course of user login... deal with it.
    } on KakaoClientException catch (e) {
      _logger.e(e);
      //
    } catch (e) {
      _logger.e(e);
      //
    }
  }

  Future<AccessToken> getToken() {
    return AccessTokenStore.instance.fromStore();
  }
}
