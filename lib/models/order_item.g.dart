// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    id: json['id'] as int,
    item: json['item'] == null
        ? null
        : Item.fromJson(json['item'] as Map<String, dynamic>),
    unitAmount: (json['unitAmount'] as num)?.toDouble(),
    quantity: (json['quantity'] as num)?.toDouble(),
    comment: json['comment'] as String,
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('item', instance.item?.toJson());
  writeNotNull('unitAmount', instance.unitAmount);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('comment', instance.comment);
  return val;
}
