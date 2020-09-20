import 'package:flutter/material.dart';
import 'package:jmorder_app/models/order_item.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem orderItem;
  final void Function(OrderItem) onDelete;
  OrderListItem(this.orderItem, {Key key, @required this.onDelete})
      : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState(orderItem);
}

class _OrderListItemState extends State<OrderListItem> {
  OrderItem _orderItem;

  _OrderListItemState(this._orderItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_orderItem.item?.name),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      subtitle: Row(
        children: [
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                if (_orderItem.hasUnit()) {
                  return Text(
                    "단위 없음",
                    textAlign: TextAlign.center,
                  );
                }
                return TextFormField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  initialValue: _orderItem.unitAmount?.toString(),
                  onChanged: (value) {
                    _orderItem.unitAmount = double.parse(value);
                  },
                  decoration: InputDecoration(
                    suffixText: _orderItem.item.unitName,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.end,
              initialValue: _orderItem.cleanQuantity?.toString(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                _orderItem.quantity = double.parse(value);
              },
              decoration: InputDecoration(
                  suffixText: _orderItem.item.quantityName,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _orderItem.quantity = 0;
                      });
                    },
                  )),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => widget.onDelete(_orderItem),
      ),
    );
  }
}
