import 'package:flutter/material.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/components/dialog/client/client_basic_info_form_dialog.dart';
import 'package:jmorder_app/widgets/pages/main/chat_view.dart';
import 'package:jmorder_app/widgets/pages/main/client_view.dart';
import 'package:jmorder_app/widgets/pages/main/settings_view.dart';
import 'package:jmorder_app/widgets/pages/main/staffs_view.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MainPage extends StatelessWidget {
  final int targetIndex;
  const MainPage({Key key, this.targetIndex}) : super(key: key);

  static const String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    return bottomNavigationState.rebuilder(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              buildTitle(),
              textAlign: TextAlign.center,
            ),
            actions: buildActions(context),
          ),
          body: SafeArea(
            top: false,
            child: [profileService].whenRebuilderOr(
              onWaiting: () => Center(
                child: CircularProgressIndicator(),
              ),
              builder: () {
                final currentIndex = bottomNavigationState.state;
                switch (currentIndex) {
                  case StaffsView.viewIndex: // 0
                    return StaffsView();
                  case ChatView.viewIndex: // 1
                    return ChatView();
                  case SettingsView.viewIndex:
                    return SettingsView();
                  case ClientView.viewIndex: // 3
                    return ClientView();

                  case 2: // TODO
                  default:
                    {
                      return Container(
                        child: Center(
                          child: Text(currentIndex.toString()),
                        ),
                      );
                    }
                }
              },
            ),
          ),
          bottomNavigationBar: buildBottomNavigationBar(context),
        ));
  }

  String buildTitle() {
    final currentIndex = bottomNavigationState.state;
    switch (currentIndex) {
      case StaffsView.viewIndex: // 0
        return StaffsView.title;
      case ChatView.viewIndex: // 1
        return ChatView.title;
      case SettingsView.viewIndex:
        return SettingsView.title;
      case ClientView.viewIndex: // 3
        return ClientView.title;

      case 2: // TODO
      default:
        return "주먹맛볼래";
    }
  }

  List<Widget> buildActions(BuildContext context) {
    final currentIndex = bottomNavigationState.state;
    switch (currentIndex) {
      case StaffsView.viewIndex: // 0
        return [];
      case ChatView.viewIndex: // 1
        return [];
      case SettingsView.viewIndex:
        return [];
      case ClientView.viewIndex: // 3
        return ClientView.appBarActions(context);
      case 2: // TODO
      default:
        return [];
    }
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: (index) => bottomNavigationState.setState((s) => s = index),
      currentIndex: bottomNavigationState.state,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "스태프",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: "톡",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "발주",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: "거래처",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "설정",
        ),
      ],
    );
  }
}
