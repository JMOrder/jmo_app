import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/models/order_item.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/components/order/order_list_item.dart';
import 'package:jmorder_app/widgets/components/order/order_search_item.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends StatelessWidget {
  static const String routeName = '/main/orders/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: orderService.rebuilder(() => Text(
            selectedOrderState.state.model.createdAt.toLocal().toString())),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                RM.scaffoldShow.snackBar(SnackBar(
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
                await selectedOrderState.setState((s) => s.updateOrder());
                RM.scaffoldShow.snackBar(SnackBar(
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
                String message =
                    selectedOrderState.state.model.createOrderMessage();
                bool didCopy = await RM.navigate.toDialog(AlertDialog(
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
                            return RM.navigate.back(true);
                          },
                        ),
                        FlatButton(
                          child: Text("취소"),
                          onPressed: () => RM.navigate.back(false),
                        )
                      ],
                    )) ??
                    false;
                if (didCopy)
                  RM.scaffoldShow.snackBar(SnackBar(
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
                  child: selectedOrderState.whenRebuilderOr(
                    builder: () => Column(children: [
                      Card(
                        elevation: 8.0,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          initiallyExpanded: true,
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
                              title: Text(
                                  selectedOrderState.state.model.user.fullName),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text(
                                  selectedOrderState.state.model.client.name),
                              subtitle: Text(
                                  selectedOrderState.state.model.client.phone),
                              onTap: () => launch(
                                  "tel:${selectedOrderState.state.model.client.phone}"),
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
                                    List<Item> items = selectedOrderState
                                        .state.model.client.items
                                      ..removeWhere((item) => selectedOrderState
                                          .state.model.orderItems
                                          .any((orderItem) =>
                                              orderItem.item == item));
                                    showSearch(
                                      context: context,
                                      delegate: OrderSearchItem(items),
                                    ).then((item) async {
                                      if (item == null) return;
                                      await selectedOrderState.setState(
                                          (s) => s.addOrderItem(OrderItem(
                                                item: item,
                                                quantity: 0,
                                              )));
                                    });
                                  },
                                ),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: selectedOrderState
                                  .state.model.orderItems.length,
                              itemBuilder: (context, index) {
                                final orderItem = selectedOrderState
                                    .state.model.orderItems[index];
                                return OrderListItem(
                                  orderItem,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              )),
    );
  }
}
