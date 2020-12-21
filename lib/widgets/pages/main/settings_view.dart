import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/pages/auth_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SettingsView extends StatelessWidget {
  static const int viewIndex = 4;
  static const String title = "설정";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(8.0),
            color: Theme.of(context).primaryColor,
            child: ListTile(
              onTap: () => {},
              title: Text(
                profileService.state.fullName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  'https://kansai-resilience-forum.jp/wp-content/uploads/2019/02/IAFOR-Blank-Avatar-Image-1.jpg',
                ),
              ),
              trailing: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("비밀번호 변경"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("언어 변경"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("문의하기"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("로그아웃"),
                  onTap: () async {
                    await authService.setState((s) => s.logout());
                    RM.navigate.toNamedAndRemoveUntil(AuthPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
