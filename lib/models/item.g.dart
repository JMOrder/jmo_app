// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    name: json['name'] as String,
    unitName: json['unitName'] as String,
    quantityName: json['quantityName'] as String,
    comment: json['comment'] as String,
    favorite: json['favorite'] as bool,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('unitName', instance.unitName);
  writeNotNull('quantityName', instance.quantityName);
  writeNotNull('comment', instance.comment);
  writeNotNull('favorite', instance.favorite);
  return val;
}
