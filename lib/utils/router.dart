import 'package:flutter/material.dart';
import 'package:jmorder_app/widgets/pages/auth_page.dart';
import 'package:jmorder_app/widgets/pages/main_page.dart';
import 'package:jmorder_app/widgets/pages/registration_page.dart';
import 'package:jmorder_app/widgets/pages/verification_page.dart';

import 'injected.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        var targetIndex = (settings.arguments as int) ?? 0;
        profileService.setState((s) => s.fetchProfile());
        clientService.setState((s) => s.fetchClients());
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  targetIndex: targetIndex,
                ));
      case AuthPage.routeName:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case RegistrationPage.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case VerificationPage.routeName:
        return MaterialPageRoute(builder: (_) => VerificationPage());
      // case OrderDetailPage.routeName:
      //   OrderDetailPageArgument args = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => OrderDetailPage(
      //             order: args.order,
      //             isNew: args.isNew,
      //           ));
      // case ClientDetailPage.routeName:
      //   var client = settings.arguments as Client;
      //   return MaterialPageRoute(
      //       builder: (_) => ClientDetailPage(client: client));
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
