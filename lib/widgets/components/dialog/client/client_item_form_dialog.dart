import 'package:flutter/material.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ClientItemFormDialog extends StatefulWidget {
  final Item item;
  ClientItemFormDialog({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _ClientItemFormDialogState createState() => _ClientItemFormDialogState();
}

class _ClientItemFormDialogState extends State<ClientItemFormDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _quantityNameController = TextEditingController();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    this._nameController.text = widget.item?.name;
    this._unitNameController.text = widget.item?.unitName;
    this._quantityNameController.text = widget.item?.quantityName;
    this.isFavorite = widget.item?.favorite ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _unitNameController.dispose();
    _quantityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            widget.item == null ? "새 품목" : "품목 관리",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: widget.item == null
              ? null
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.grey,
                  onPressed: () =>
                      RM.navigate.toDialog(AlertDialog(
                        content: Text("정말 삭제하시겠습니까?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("확인"),
                            onPressed: () async {
                              RM.navigate.back(true);
                            },
                          ),
                          FlatButton(
                            child: Text("취소"),
                            onPressed: () => RM.navigate.back(false),
                          )
                        ],
                      )) ??
                      false,
                ),
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
                  setState(() {
                    isFavorite = value;
                  });
                },
                value: isFavorite,
                title: Text("즐겨찾기"),
              )
            ],
          ),
        ],
      ),
      actions: [
        new FlatButton(
          child: new Text('취소'),
          onPressed: () => RM.navigate.back(),
        ),
        new FlatButton(
          child: new Text(widget.item != null ? "수정" : "추가"),
          onPressed: () async {
            if (this.widget.item == null) {
              await selectedClientState.setState((s) => s.addItem(Item(
                    name: _nameController.text,
                    unitName: _unitNameController.text,
                    quantityName: _quantityNameController.text,
                    favorite: isFavorite,
                  )));
            } else {
              await selectedClientState.setState((s) => s.editItem(Item(
                    id: widget.item.id,
                    name: _nameController.text,
                    unitName: _unitNameController.text,
                    quantityName: _quantityNameController.text,
                    favorite: isFavorite,
                  )));
            }
            RM.navigate.back(true);
          },
        ),
      ],
    );
  }
}
