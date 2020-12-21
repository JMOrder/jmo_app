import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/components/dialog/client/client_basic_info_form_dialog.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ClientView extends StatelessWidget {
  static const int viewIndex = 3;
  static const String title = "거래처";

  static List<Widget> appBarActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () => RM.navigate.toDialog(ClientBasicInfoFormDialog())),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return clientService.whenRebuilderOr(
      builder: () => ListView.builder(
          itemCount: clientService.state.clients.length,
          itemBuilder: (context, index) {
            Client client = clientService.state.clients[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFFFF0844), Color(0xFFFFB199)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) async {
                await clientService.setState((s) => s.deleteClient(client));
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("정상적으로 삭제되었습니다."),
                  duration: Duration(milliseconds: 500),
                ));
              },
              confirmDismiss: (direction) async =>
                  showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("정말 삭제하시겠습니까?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("확인"),
                          onPressed: () {
                            // Dismiss the dialog and
                            // also dismiss the swiped item
                            Navigator.of(context).pop(true);
                          },
                        ),
                        FlatButton(
                          child: Text("취소"),
                          onPressed: () {
                            // Dismiss the dialog but don't
                            // dismiss the swiped item
                            return Navigator.of(context).pop(false);
                          },
                        )
                      ],
                    ),
                  ) ??
                  false,
              child: ListTile(
                onTap: () async {},
                onLongPress: () {
                  print("Pressed: ${client.phone}");
                },
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://kansai-resilience-forum.jp/wp-content/uploads/2019/02/IAFOR-Blank-Avatar-Image-1.jpg',
                  ),
                ),
                title: Text(client.name),
                subtitle: Text(client.phone),
              ),
            );
          }),
    );
  }
}
