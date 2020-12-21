import 'package:flutter/material.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientBasicInfoFormDialog extends StatefulWidget {
  @override
  _ClientBasicInfoFormDialogState createState() =>
      _ClientBasicInfoFormDialogState();
}

class _ClientBasicInfoFormDialogState extends State<ClientBasicInfoFormDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: "###-####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void submitClientCreate(BuildContext context) async {
    final newClient = Client(
      name: _nameController.text,
      phone: _phoneController.text,
    );
    await clientService.setState((s) => s.addClient(newClient));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("기본정보"),
      content: Column(
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
                textInputAction: TextInputAction.next,
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
                onFieldSubmitted: (value) =>
                    _fieldFocusChange(context, _phoneFocus, _addressFocus),
              ),
              SizedBox(height: 10),
              TextFormField(
                key: ValueKey("address"),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _addressController,
                focusNode: _addressFocus,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  hintText: "주소",
                  suffixIcon: IconButton(
                    onPressed: () => _addressController.clear(),
                    icon: Icon(Icons.clear),
                    iconSize: 20,
                  ),
                ),
                onFieldSubmitted: (value) => submitClientCreate(context),
              ),
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
          onPressed: () => submitClientCreate(context),
        ),
      ],
    );
  }
}
