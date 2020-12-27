import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jmorder_app/models/order.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/components/order/order_search_client.dart';
import 'package:jmorder_app/widgets/pages/main/order/order_detail.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OrderView extends StatelessWidget {
  static const int viewIndex = 2;
  static const String title = "발주";

  static List<Widget> appBarActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          showSearch(
            context: context,
            delegate: OrderSearchClient(),
          ).then((item) {});
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 0,
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          itemCount: orderService.state.orders.length,
          itemBuilder: (context, index) {
            Order order = orderService.state.orders[index];
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
                await orderService.setState((s) => s.deleteOrder(order));
                RM.scaffoldShow.snackBar(SnackBar(
                  content: Text("정상적으로 삭제되었습니다."),
                  duration: Duration(milliseconds: 500),
                ));
              },
              confirmDismiss: (direction) async =>
                  RM.navigate.toDialog(AlertDialog(
                    content: Text("정말 삭제하시겠습니까?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("확인"),
                        onPressed: () {
                          orderService.state.orders.remove(order);
                          return RM.navigate.back(true);
                        },
                      ),
                      FlatButton(
                        child: Text("취소"),
                        onPressed: () => RM.navigate.back(false),
                      )
                    ],
                  )) ??
                  false,
              child: ListTile(
                onTap: () async {
                  await selectedOrderState.setState((s) => s.select(order.id));
                  RM.navigate.toNamed(OrderDetail.routeName);
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
                title:
                    Text(DateFormat.yMMMMd().add_jm().format(order.createdAt)),
                subtitle: Text(
                    "발주자: ${order.user.fullName} / 거래처: ${order.client.name}"),
              ),
            );
          },
        ),
        onRefresh: () async => orderService.setState((s) => s.fetchOrders()));
  }
}

class OrderDetailPage {}
