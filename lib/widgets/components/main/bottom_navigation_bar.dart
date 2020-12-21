// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jmorder_app/utils/injected.dart';

// class CustomBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       showSelectedLabels: true,
//       showUnselectedLabels: false,
//       onTap: (toIndex) => bottomNavigationState.setState((s) => s.to(toIndex))
//       currentIndex: bottomNavigationState.state.currentIndex,
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
