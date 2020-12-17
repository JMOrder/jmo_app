// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:jmorder_app/bloc/clients/clients_bloc.dart';
// import 'package:jmorder_app/bloc/clients/clients_event.dart';
// import 'package:jmorder_app/bloc/clients/clients_state.dart';
// import 'package:jmorder_app/models/client.dart';
// import 'package:jmorder_app/services/clients_service.dart';
// import 'package:jmorder_app/widgets/pages/client/client_detail_page.dart';

// class ClientsView extends StatelessWidget {
//   static const int viewIndex = 3;
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<ClientsBloc>(context).add(ClientsViewLoaded());
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           BlocConsumer<ClientsBloc, ClientsState>(
//             listener: (context, state) {
//               if (state is ClientAddedState) {
//                 Navigator.pushNamed(
//                   context,
//                   ClientDetailPage.routeName,
//                   arguments: state.client,
//                 );
//               }
//             },
//             builder: (context, state) {
//               if (state is ClientsLoadedState) {
//                 return ListView.builder(
//                     itemCount: state.clients.length,
//                     itemBuilder: (context, index) {
//                       Client client = state.clients[index];
//                       return Dismissible(
//                         key: UniqueKey(),
//                         direction: DismissDirection.endToStart,
//                         background: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: <Color>[
//                                 Color(0xFFFF0844),
//                                 Color(0xFFFFB199)
//                               ],
//                               begin: Alignment.centerRight,
//                               end: Alignment.centerLeft,
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           alignment: AlignmentDirectional.centerEnd,
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                           ),
//                         ),
//                         onDismissed: (direction) async {
//                           await GetIt.I
//                               .get<ClientsService>()
//                               .deleteClient(client);
//                           Scaffold.of(context).showSnackBar(SnackBar(
//                             content: Text("정상적으로 삭제되었습니다."),
//                             duration: Duration(milliseconds: 500),
//                           ));
//                         },
//                         confirmDismiss: (direction) async =>
//                             showDialog<bool>(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 content: Text("정말 삭제하시겠습니까?"),
//                                 actions: <Widget>[
//                                   FlatButton(
//                                     child: Text("확인"),
//                                     onPressed: () {
//                                       // Dismiss the dialog and
//                                       // also dismiss the swiped item
//                                       Navigator.of(context).pop(true);
//                                     },
//                                   ),
//                                   FlatButton(
//                                     child: Text("취소"),
//                                     onPressed: () {
//                                       // Dismiss the dialog but don't
//                                       // dismiss the swiped item
//                                       return Navigator.of(context).pop(false);
//                                     },
//                                   )
//                                 ],
//                               ),
//                             ) ??
//                             false,
//                         child: ListTile(
//                           onTap: () async {
//                             Client openClient = await GetIt.I
//                                 .get<ClientsService>()
//                                 .fetchClientById(client.id);
//                             Navigator.pushNamed(
//                               context,
//                               ClientDetailPage.routeName,
//                               arguments: openClient,
//                             );
//                           },
//                           onLongPress: () {
//                             print("Pressed: ${client.phone}");
//                           },
//                           leading: CircleAvatar(
//                             backgroundImage: CachedNetworkImageProvider(
//                               'https://kansai-resilience-forum.jp/wp-content/uploads/2019/02/IAFOR-Blank-Avatar-Image-1.jpg',
//                             ),
//                           ),
//                           title: Text(client.name),
//                           subtitle: Text(client.phone),
//                         ),
//                       );
//                     });
//               }
//               return Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Colors.white,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
