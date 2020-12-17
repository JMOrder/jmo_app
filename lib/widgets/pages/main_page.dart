// import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_event.dart';
// import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_bloc.dart';
// import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jmorder_app/bloc/auth/auth_bloc.dart';
// import 'package:jmorder_app/bloc/auth/auth_state.dart';
// import 'package:jmorder_app/widgets/components/dialog/client/client_basic_info_form_dialog.dart';
// import 'package:jmorder_app/widgets/components/order/order_search_client.dart';
// import 'package:jmorder_app/widgets/components/main/main_page_bottom_navigation_bar.dart';
// import 'package:jmorder_app/widgets/views/staffs_view.dart';
// import 'package:jmorder_app/widgets/views/chat_view.dart';
// import 'package:jmorder_app/widgets/views/orders_view.dart';
// import 'package:jmorder_app/widgets/views/settings_view.dart';
// import 'package:jmorder_app/widgets/views/clients_view.dart';

// class MainPage extends StatelessWidget {
//   final int targetIndex;
//   const MainPage({Key key, this.targetIndex}) : super(key: key);

//   static const String routeName = '/main';
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<BottomNavigationBloc>(context)
//         .add(PageTapped(index: targetIndex));
//     String appBarTitle = "주먹맛볼래";
//     List<Widget> appBarActions = [];
//     return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
//       listener: (BuildContext context, state) {
//         if (state is StaffsViewState) {
//           appBarTitle = "스태프";
//           appBarActions = [];
//         }
//         if (state is ChatViewState) {
//           appBarTitle = "톡";
//           appBarActions = [];
//         }
//         if (state is OrdersViewState) {
//           appBarTitle = "발주";
//           appBarActions = [
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: OrderSearchClient(),
//                 ).then((item) {});
//               },
//             ),
//           ];
//         }
//         if (state is ClientsViewState) {
//           appBarTitle = "거래처";
//           appBarActions = [
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () => showDialog(
//                 context: context,
//                 builder: (context) => ClientBasicInfoFormDialog(),
//               ),
//             ),
//           ];
//         }
//         if (state is SettingsViewState) {
//           appBarTitle = "설정";
//           appBarActions = [];
//         }
//       },
//       builder: (context, navState) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             appBarTitle,
//             textAlign: TextAlign.center,
//           ),
//           actions: appBarActions,
//         ),
//         body: SafeArea(
//           top: false,
//           child: BlocBuilder<AuthBloc, AuthState>(
//             builder: (context, authState) {
//               if (authState is AuthRequestState || navState is ViewLoading) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               if (navState is ChatViewState) return ChatView();
//               if (navState is StaffsViewState) return StaffsView();
//               if (navState is OrdersViewState) return OrdersView();
//               if (navState is ClientsViewState) return ClientsView();
//               if (navState is SettingsViewState) return SettingsView();
//               return Container();
//             },
//           ),
//         ),
//         bottomNavigationBar: MainPageBottomNavigationBar(),
//       ),
//     );
//   }
// }
