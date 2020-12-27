import 'package:flutter/material.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ClientBasicInfoFormDialog extends StatefulWidget {
  @override
  _ClientBasicInfoFormDialogState createState() =>
      _ClientBasicInfoFormDialogState();
}

class _ClientBasicInfoFormDialogState extends State<ClientBasicInfoFormDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: "###-####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void submitClientCreate() async {
    final newClient = Client(
      name: _nameController.text,
      phone: _phoneController.text,
    );
    RM.navigate.back();
    await clientService.setState((s) => s.addClient(newClient));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text("기본정보"),
      content: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: <Widget>[
                TextFormField(
                  key: ValueKey("name"),
                  controller: _nameController,
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "상호명",
                    suffixIcon: IconButton(
                      onPressed: () => _nameController.clear(),
                      icon: Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ),
                  onFieldSubmitted: (value) =>
                      _fieldFocusChange(context, _nameFocus, _phoneFocus),
                ),
                SizedBox(height: 10),
                TextFormField(
                  key: ValueKey("phone"),
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_phoneMaskFormatter],
                  decoration: InputDecoration(
                    hintText: "전화번호",
                    suffixIcon: IconButton(
                      onPressed: () => _phoneController.clear(),
                      icon: Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ),
                  onFieldSubmitted: (_) => submitClientCreate(),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        new FlatButton(
            child: new Text('취소'), onPressed: () => RM.navigate.back()),
        new FlatButton(
          child: new Text('추가'),
          onPressed: () => submitClientCreate(),
        ),
      ],
    );
  }
}
