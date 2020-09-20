import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmorder_app/bloc/clients/clients_bloc.dart';
import 'package:jmorder_app/bloc/clients/clients_event.dart';
import 'package:jmorder_app/models/client.dart';

class ClientBasicInfoFormDialog extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void submitClientCreate(BuildContext context) {
    BlocProvider.of<ClientsBloc>(context).add(SubmitClientAdd(
      client: Client(
        name: _nameController.text,
        phone: _phoneController.text,
      ),
    ));
    _nameController.clear();
    _phoneController.clear();
    _addressController.clear();
    Navigator.of(context).pop();
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
                textInputAction: TextInputAction.go,
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
