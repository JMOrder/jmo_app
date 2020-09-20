import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/models/order.dart';
import 'package:jmorder_app/models/order_item.dart';
import 'package:jmorder_app/services/orders_service.dart';
import 'package:jmorder_app/widgets/components/order/order_list_item.dart';
import 'package:jmorder_app/widgets/components/order/order_search_item.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatefulWidget {
  static const String routeName = '/main/orders/detail';
  final Order order;
  final bool isNew;

  const OrderDetailPage({Key key, this.order, this.isNew}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState(order);
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Order _order;

  _OrderDetailPageState(this._order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isNew ? "새 발주" : "발주 관리"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("삭제 완료."),
                  duration: Duration(milliseconds: 500),
                ));
              },
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: () async {
                Order order =
                    await GetIt.I.get<OrdersService>().updateOrder(_order);
                setState(() {
                  _order = order;
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("저장 완료."),
                  duration: Duration(milliseconds: 500),
                ));
              },
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () async {
                String message = _order.createOrderMessage();
                bool didCopy = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("발주 메세지"),
                        content: Text(message),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("복사"),
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: message));
                              // Dismiss the dialog and
                              // also dismiss the swiped item
                              return Navigator.of(context).pop(true);
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
                    false;
                if (didCopy)
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("복사되었습니다. 발주를 진행해주세요."),
                    duration: Duration(milliseconds: 500),
                  ));
              },
            ),
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
                  child: Column(children: [
                    Card(
                      elevation: 8.0,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        title: ListTile(
                          title: Text(
                            "기본정보",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        children: [
                          ListTile(
                            leading: Icon(Icons.album),
                            title: Text(_order.user.fullName),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(_order.client.name),
                            subtitle: Text(_order.client.phone),
                            onTap: () => launch("tel:${_order.client.phone}"),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.grey,
                              onPressed: () {},
                            ),
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
                                onPressed: () {
                                  List<Item> items = _order.client.items
                                    ..removeWhere((item) => _order.orderItems
                                        .any((orderItem) =>
                                            orderItem.item == item));
                                  showSearch(
                                    context: context,
                                    delegate: OrderSearchItem(items),
                                  ).then((item) {
                                    if (item == null) return;
                                    OrderItem orderItem = OrderItem(
                                      item: item,
                                      quantity: 0,
                                    );
                                    _order.orderItems.add(orderItem);
                                    setState(() {
                                      _order = _order;
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _order.orderItems.length,
                            itemBuilder: (context, index) {
                              final orderItem = _order.orderItems[index];
                              return OrderListItem(
                                orderItem,
                                onDelete: (orderItem) => setState(() {
                                  log(orderItem.toJson().toString());
                                  _order = _order..orderItems.remove(orderItem);
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              )),
    );
  }
}
