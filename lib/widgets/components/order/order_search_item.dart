import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jmorder_app/models/item.dart';
import 'package:jmorder_app/services/jmo_api_service.dart';
import 'package:jmorder_app/utils/dependency_injector.dart';

class OrderSearchItem extends SearchDelegate {
  final List<Item> _items;

  OrderSearchItem(this._items);

  Future<List<Item>> searchItems(String query) async {
    var response =
        await getIt<JmoApiService>().getClient().get("/clients/1/items");
    return List<Map>.from(response.data)
        .map((Map model) => Item.fromJson(model))
        .toList();
  }

  Future<List<Item>> queryChanged(String query) async {
    // if (debounceActive) return null;
    // debounceActive = true;
    // await Future.delayed(Duration(milliseconds: 2000));
    // var response = await getIt<ApiService>().getClient().get(
    //   "/clients/1/items/search",
    //   queryParameters: {"q": query},
    // );
    // List<Item> items = List<Map>.from(response.data)
    //     .map((Map model) => Item.fromJson(model))
    //     .toList();
    // debounceActive = false;
    // return items;
    // hit your api here
    // var response = await getIt<ApiService>().getClient().get(
    //   "/clients/1/items/search",
    //   queryParameters: {"q": query},
    // );
    // return List<Map>.from(response.data)
    //     .map((Map model) => Item.fromJson(model))
    //     .toList();

    return this
        ._items
        .where((item) => item.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () async {
          query = '';
        },
      ),
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
    return FutureBuilder<List<Item>>(
      future: queryChanged(query),
      builder: (BuildContext context, AsyncSnapshot<List<Item>> itemsSnapshot) {
        if (!itemsSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final List<Item> items = itemsSnapshot.data;
        items.sort((i1, i2) => i1.favorite ? 0 : 1);
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index].name),
            trailing: items[index].favorite
                ? Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                  )
                : null,
            onTap: () {
              close(context, items[index]);
            },
          ),
          itemCount: items.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
