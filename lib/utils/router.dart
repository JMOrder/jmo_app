import 'package:flutter/material.dart';
import 'package:jmorder_app/widgets/pages/auth_page.dart';
import 'package:jmorder_app/widgets/pages/main/client/client_detail.dart';
import 'package:jmorder_app/widgets/pages/main/order/order_detail.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:jmorder_app/widgets/pages/registration_page.dart';
import 'package:jmorder_app/widgets/pages/verification_page.dart';

import 'injected.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        profileService.setState((s) => s.fetchProfile());
        clientService.setState((s) => s.fetchClients());
        orderService.setState((s) => s.fetchOrders());
        return MaterialPageRoute(builder: (_) => MainPage());
      case AuthPage.routeName:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case RegistrationPage.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case VerificationPage.routeName:
        return MaterialPageRoute(builder: (_) => VerificationPage());
      case OrderDetail.routeName:
        return MaterialPageRoute(builder: (_) => OrderDetail());
      case ClientDetail.routeName:
        return MaterialPageRoute(builder: (_) => ClientDetail());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

// class OrderDetailPageArgument {
//   final Order order;
//   final bool isNew;

//   OrderDetailPageArgument({this.order, this.isNew});
// }
