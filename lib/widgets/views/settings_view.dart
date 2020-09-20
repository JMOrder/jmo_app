import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
import 'package:jmorder_app/bloc/auth/auth_event.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/widgets/pages/auth_page.dart';

class SettingsView extends StatelessWidget {
  static const int viewIndex = 4;
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
                GetIt.I.get<AuthService>().profile?.fullName ?? "",
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
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AuthPage.routeName, (r) => false);
                    BlocProvider.of<AuthBloc>(context).add(LogoutSubmitted());
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
