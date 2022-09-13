// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishAdapter extends TypeAdapter<Dish> {
  @override
  final int typeId = 0;

  @override
  Dish read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dish(
      name: fields[0] as String,
      price: fields[4] as double,
      id: fields[3] as String,
      imgUrl: fields[1] as String,
      isHot: fields[2] as bool,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dish obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imgUrl)
      ..writeByte(2)
      ..write(obj.isHot)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
