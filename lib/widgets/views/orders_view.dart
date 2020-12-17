// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:intl/intl.dart';
// import 'package:jmorder_app/bloc/orders/orders_bloc.dart';
// import 'package:jmorder_app/bloc/orders/orders_event.dart';
// import 'package:jmorder_app/bloc/orders/orders_state.dart';
// import 'package:jmorder_app/models/order.dart';
// import 'package:jmorder_app/services/orders_service.dart';
// import 'package:jmorder_app/utils/router.dart';
// import 'package:jmorder_app/widgets/pages/order/order_detail_page.dart';

// class OrdersView extends StatelessWidget {
//   static const int viewIndex = 2;
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<OrdersBloc>(context).add(OrdersViewLoaded());
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           BlocBuilder<OrdersBloc, OrdersState>(
//             builder: (context, state) {
//               if (state is OrdersLoadedState) {
//                 return ListView.separated(
//                   separatorBuilder: (context, index) => Divider(
//                     height: 0,
//                     indent: 10,
//                     endIndent: 10,
//                     color: Colors.grey,
//                   ),
//                   itemCount: state.orders.length,
//                   itemBuilder: (context, index) {
//                     Order order = state.orders[index];
//                     return Dismissible(
//                       key: UniqueKey(),
//                       direction: DismissDirection.endToStart,
//                       background: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: <Color>[
//                               Color(0xFFFF0844),
//                               Color(0xFFFFB199)
//                             ],
//                             begin: Alignment.centerRight,
//                             end: Alignment.centerLeft,
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         alignment: AlignmentDirectional.centerEnd,
//                         child: Icon(
//                           Icons.delete,
//                           color: Colors.white,
//                         ),
//                       ),
//                       onDismissed: (direction) async {
//                         await GetIt.I.get<OrdersService>().deleteOrder(order);
//                         Scaffold.of(context).showSnackBar(SnackBar(
//                           content: Text("정상적으로 삭제되었습니다."),
//                           duration: Duration(milliseconds: 500),
//                         ));
//                       },
//                       confirmDismiss: (direction) async =>
//                           showDialog<bool>(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               content: Text("정말 삭제하시겠습니까?"),
//                               actions: <Widget>[
//                                 FlatButton(
//                                   child: Text("확인"),
//                                   onPressed: () {
//                                     // Dismiss the dialog and
//                                     // also dismiss the swiped item
//                                     state.orders.remove(order);
//                                     Navigator.of(context).pop(true);
//                                   },
//                                 ),
//                                 FlatButton(
//                                   child: Text("취소"),
//                                   onPressed: () {
//                                     // Dismiss the dialog but don't
//                                     // dismiss the swiped item
//                                     return Navigator.of(context).pop(false);
//                                   },
//                                 )
//                               ],
//                             ),
//                           ) ??
//                           false,
//                       child: ListTile(
//                         onTap: () async {
//                           Order fetchedOrder = await GetIt.I
//                               .get<OrdersService>()
//                               .fetchOrderById(order.id);
//                           return Navigator.of(context)
//                               .pushNamed(OrderDetailPage.routeName,
//                                   arguments: OrderDetailPageArgument(
//                                     order: fetchedOrder,
//                                     isNew: false,
//                                   ));
//                         },
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.transparent,
//                           child: Icon(
//                             Icons.check,
//                             color: Colors.green,
//                           ),
//                         ),
//                         title: Text(DateFormat.yMMMMd()
//                             .add_jm()
//                             .format(order.createdAt)),
//                         subtitle: Text(
//                             "발주자: ${order.user.fullName} / 거래처: ${order.client.name}"),
//                       ),
//                     );
//                   },
//                 );
//               }
//               return Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Colors.transparent,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
