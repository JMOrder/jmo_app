import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/services/clients_service.dart';
import 'package:jmorder_app/widgets/components/client/client_item_form_dialog.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:jmorder_app/widgets/views/clients_view.dart';

class ClientDetailPage extends StatefulWidget {
  static const String routeName = '/main/clients/detail';
  final Client client;

  const ClientDetailPage({Key key, this.client}) : super(key: key);

  @override
  _ClientDetailPageState createState() => _ClientDetailPageState(this.client);
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  Client _client;

  _ClientDetailPageState(this._client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_client.name),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await GetIt.I.get<ClientsService>().deleteClient(_client);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  MainPage.routeName,
                  (r) => false,
                  arguments: ClientsView.viewIndex,
                );
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
                          title: Text(_client.name),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(_client.phone),
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
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => ClientItemFormDialog(
                                  client: _client,
                                  afterSubmit: (client) =>
                                      setState(() => _client = client),
                                ),
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
                          itemCount: _client.items.length,
                          itemBuilder: (context, index) {
                            Item item = _client.items[index];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFFF0844),
                                      Color(0xFFFFB199)
                                    ],
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
                                await GetIt.I
                                    .get<ClientsService>()
                                    .deleteItem(client: _client, item: item);
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
                                            return Navigator.of(context)
                                                .pop(false);
                                          },
                                        )
                                      ],
                                    ),
                                  ) ??
                                  false,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ClientItemFormDialog(
                                      client: _client,
                                      item: item,
                                      afterSubmit: (client) {
                                        setState(() {
                                          _client = client;
                                        });
                                      },
                                    ),
                                  );
                                  print("Pressed: ${item.name}");
                                },
                                title: Text(item.name),
                                subtitle: Text(
                                    "단위: ${item.unitName ?? "해당없음"} / 수량 단위: ${item.quantityName ?? "해당없음"}"),
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
  }
}
