import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:jmorder_app/app.dart';

class DynamicLinkService {
  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;

      if (deepLink != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => App()));
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => App()));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///createDynamicLink()
}
