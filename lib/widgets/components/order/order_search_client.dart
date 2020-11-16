import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jmorder_app/bloc/orders/orders_bloc.dart';
import 'package:jmorder_app/bloc/orders/orders_event.dart';
import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/models/order.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/services/auth_service.dart';
import 'package:jmorder_app/services/orders_service.dart';
import 'package:jmorder_app/utils/router.dart';
import 'package:jmorder_app/widgets/pages/order/order_detail_page.dart';

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
    // if (debounceActive) return null;
    // debounceActive = true;
    // await Future.delayed(Duration(milliseconds: 2000));
    // var response = await GetIt.I.get<ApiService>().getClient().get(
    //   "/clients/1/items/search",
    //   queryParameters: {"q": query},
    // );
    // List<Item> items = List<Map>.from(response.data)
    //     .map((Map model) => Item.fromJson(model))
    //     .toList();
    // debounceActive = false;
    // return items;
    // hit your api here
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
              Order order = await GetIt.I.get<OrdersService>().createOrder(
                    Order(
                      user: GetIt.I.get<AuthService>().profile.toUser(),
                      client: clients[index],
                    ),
                  );
              BlocProvider.of<OrdersBloc>(context).add(OrdersListRefreshed());
              Navigator.of(context).popAndPushNamed(OrderDetailPage.routeName,
                  arguments:
                      OrderDetailPageArgument(order: order, isNew: true));
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
