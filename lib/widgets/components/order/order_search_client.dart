import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/states/selected_order_state.dart';
import 'package:jmorder_app/utils/injected.dart';
import 'package:jmorder_app/widgets/pages/main/order/order_detail.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OrderSearchClient extends SearchDelegate {
  OrderSearchClient() : super(searchFieldLabel: "거래처 검색");

  Future<List<Client>> searchClients(String query) async {
    var response =
        await GetIt.I.get<JmoApiService>().getClient().get("/clients/search");
    return List<Map>.from(response.data)
        .map((Map model) => Client.fromJson(model))
        .toList();
  }

  Future<List<Client>> queryChanged(String query) async {
    var response = await GetIt.I.get<JmoApiService>().getClient().get(
      "/clients/search",
      queryParameters: {"q": query},
    );
    return List<Map>.from(response.data)
        .map((Map model) => Client.fromJson(model))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () async {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Client>>(
      future: queryChanged(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<Client>> clientsSnapshot) {
        if (!clientsSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final List<Client> clients = clientsSnapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(clients[index].name),
            leading: Icon(
              Icons.star,
              color: Colors.orangeAccent,
            ),
            onTap: () async {
              // close(context, clients[index]);
              await orderService.setState((s) => s.createOrder(clients[index]));
              RM.navigate.backAndToNamed(OrderDetail.routeName);
            },
          ),
          itemCount: clients.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
