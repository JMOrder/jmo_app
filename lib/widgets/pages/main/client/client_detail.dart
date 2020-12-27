import 'package:flutter/material.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/components/dialog/client/client_item_form_dialog.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ClientDetail extends StatelessWidget {
  static const String routeName = '/main/clients/detail';
  const ClientDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectedClientState.rebuilder(() {
      final client = selectedClientState.state.model;
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(client.name),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await selectedClientState.setState((s) => s.delete());
                  selectedClientState.setState((s) => s = null);
                  RM.navigate.toNamedAndRemoveUntil(MainPage.routeName);
                },
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                  maxWidth: constraints.maxWidth,
                ),
                child: Column(
                  children: [
                    Card(
                      elevation: 8.0,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: ListTile(
                              title: Text(
                                "기본정보",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.album),
                            title: Text(client.name),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(client.phone),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 8.0,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: ListTile(
                              title: Text(
                                "품목",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.grey,
                                onPressed: () => RM.navigate.toDialog(
                                  ClientItemFormDialog(),
                                ),
                              ),
                            ),
                          ),
                          ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              height: 0,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.grey,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: client.items.length,
                            itemBuilder: (context, index) {
                              Item item = client.items[index];
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Theme.of(context).accentColor,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (direction) async {
                                  await selectedClientState
                                      .setState((s) => s.deleteItem(item));
                                  RM.scaffoldShow.snackBar(SnackBar(
                                    content: Text("삭제되었습니다."),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                },
                                confirmDismiss: (direction) async =>
                                    RM.navigate.toDialog(AlertDialog(
                                      content: Text("정말 삭제하시겠습니까?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("확인"),
                                          onPressed: () =>
                                              RM.navigate.back(true),
                                        ),
                                        FlatButton(
                                          child: Text("취소"),
                                          onPressed: () =>
                                              RM.navigate.back(false),
                                        )
                                      ],
                                    )) ??
                                    false,
                                child: ListTile(
                                  onTap: () =>
                                      RM.navigate.toDialog(ClientItemFormDialog(
                                    item: item,
                                  )),
                                  title: Text(item.name),
                                  subtitle: Text(
                                      "단위: ${item.unitName ?? "해당없음"} / 수량 단위: ${item.quantityName ?? "해당없음"}"),
                                  trailing: item.favorite
                                      ? Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        )
                                      : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
