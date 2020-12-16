import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:jmorder_app/app.dart';

class FirebaseDynamicService {
  // Future<void> retrieveDynamicLink(BuildContext context) async {
  //   try {
  //     final PendingDynamicLinkData data =
  //         await FirebaseDynamicLinks.instance.getInitialLink();
  //     final Uri deepLink = data?.link;

  //     if (deepLink != null) {
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => App()));
  //     }

  //     FirebaseDynamicLinks.instance.onLink(
  //         onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => App()));
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // static void initDynamicLinks() async {
  //   final PendingDynamicLinkData data =
  //       await FirebaseDynamicLinks.instance.getInitialLink();

  //   _handleDynamicLink(data);

  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //     _handleDynamicLink(dynamicLink);
  //   }, onError: (OnLinkErrorException e) async {
  //     print('onLinkError');
  //     print(e.message);
  //   });
  // }

  // static _handleDynamicLink(PendingDynamicLinkData data) async {
  //   final Uri deepLink = data?.link;

  //   if (deepLink == null) {
  //     return;
  //   }
  //   if (deepLink.pathSegments.contains('refer')) {
  //     var title = deepLink.queryParameters['code'];
  //     if (title != null) {
  //       print("refercode=$title");
  //     }
  //   }
  // }

  // Future handleDynamicLinks() async {
  //   // 1. Get the initial dynamic link if the app is opened with a dynamic link
  //   final PendingDynamicLinkData data =
  //       await FirebaseDynamicLinks.instance.getInitialLink();

  //   // 2. handle link that has been retrieved
  //   _handleDeepLink(data);

  //   // 3. Register a link callback to fire if the app is opened up from the background
  //   // using a dynamic link.
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //     // 3a. handle link that has been retrieved
  //     _handleDeepLink(dynamicLink);
  //   }, onError: (OnLinkErrorException e) async {
  //     print('Link Failed: ${e.message}');
  //   });
  // }

  // void _handleDeepLink(PendingDynamicLinkData data) {
  //   final Uri deepLink = data?.link;
  //   if (deepLink != null) {
  //     print('_handleDeepLink | deeplink: $deepLink');
  //   }
  // }
}
