import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/services/clients_service.dart';
import 'package:meta/meta.dart';

class ClientItemFormDialog extends StatelessWidget {
  final Client client;
  final Item item;
  final Function(Client) afterSubmit;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _quantityNameController = TextEditingController();

  ClientItemFormDialog({
    Key key,
    @required this.client,
    this.item,
    this.afterSubmit,
  }) : super(key: key) {
    if (this.item != null) {
      this._nameController.text = item.name;
      this._unitNameController.text = item.unitName;
      this._quantityNameController.text = item.quantityName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(
          item == null ? "새 품목" : "품목 관리",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: item == null
            ? null
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.grey,
                onPressed: () async {
                  Function closeMainPopup =
                      () => Navigator.of(context).pop(true);
                  showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("정말 삭제하시겠습니까?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("확인"),
                          onPressed: () async {
                            // Dismiss the dialog and
                            // also dismiss the swiped item

                            await GetIt.I
                                .get<ClientsService>()
                                .deleteItem(client: client, item: item);
                            Navigator.of(context).pop(true);
                            closeMainPopup();
                            if (this.afterSubmit != null)
                              this.afterSubmit(client);
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
                  );
                },
              ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: <Widget>[
              TextField(
                key: ValueKey("name"),
                controller: _nameController,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: "품목명",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                key: ValueKey("unitName"),
                controller: _unitNameController,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: "단위 (예: kg, L, XL)",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                key: ValueKey("quantityName"),
                controller: _quantityNameController,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: "수량 (예: 개, 묶음, 박스)",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.all(0),
                onChanged: (bool value) {
                  return !value;
                },
                value: true,
                title: Text("즐겨찾기"),
              )
            ],
          ),
        ],
      ),
      actions: [
        new FlatButton(
          child: new Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text('추가'),
          onPressed: () async {
            if (this.item == null) {
              await GetIt.I.get<ClientsService>().addItem(
                    client: client,
                    item: Item(
                      name: _nameController.text,
                      unitName: _unitNameController.text,
                      quantityName: _quantityNameController.text,
                    ),
                  );
            } else {
              item.name = _nameController.text;
              item.unitName = _unitNameController.text;
              item.quantityName = _quantityNameController.text;
              await GetIt.I.get<ClientsService>().editItem(
                    client: client,
                    item: item,
                  );
            }
            _nameController.clear();
            _unitNameController.clear();
            _quantityNameController.clear();
            Navigator.of(context).pop();
            if (this.afterSubmit != null) this.afterSubmit(client);
          },
        ),
      ],
    );
  }
}
