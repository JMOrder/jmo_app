import 'package:jmorder_app/models/client.dart';
import 'package:jmorder_app/models/order_item.dart';
import 'package:jmorder_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Order {
  final int id;
  final User user;
  final Client client;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(defaultValue: [])
  final List<OrderItem> orderItems;

  Order({
    this.id,
    this.user,
    this.client,
    this.createdAt,
    this.updatedAt,
    this.orderItems = const [],
  });

  String createOrderMessage() {
    StringBuffer sb = StringBuffer();
    sb.writeln("★주먹맛볼래 배달주문★");
    orderItems.forEach((orderItem) {
      sb.write(orderItem.item.name);
      if (orderItem.item.unitName != null)
        sb.write("/${orderItem.unitAmount}${orderItem.item.unitName}");
      sb.write(" ${orderItem.cleanQuantity}${orderItem.item.quantityName}");
      if (orderItem.comment != null) {
        sb.write("(${orderItem.comment})");
      }
      sb.writeln();
    });
    return sb.toString();
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
