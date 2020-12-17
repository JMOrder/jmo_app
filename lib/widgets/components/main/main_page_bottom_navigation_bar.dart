// import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_bloc.dart';
// import 'package:jmorder_app/bloc/bottom_navigation/bottom_navigation_event.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MainPageBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       showSelectedLabels: true,
//       showUnselectedLabels: false,
//       onTap: (index) => BlocProvider.of<BottomNavigationBloc>(context)
//           .add(PageTapped(index: index)),
//       currentIndex: BlocProvider.of<BottomNavigationBloc>(context).currentIndex,
//       type: BottomNavigationBarType.fixed,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.people),
//           title: Text("스태프"),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat_bubble_outline),
//           title: Text("톡"),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart),
//           title: Text("발주"),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.business),
//           title: Text("거래처"),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           title: Text("설정"),
//         ),
//       ],
//     );
//   }
// }
