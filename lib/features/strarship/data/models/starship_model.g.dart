// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starship_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StarshipModelAdapter extends TypeAdapter<StarshipModel> {
  @override
  final int typeId = 1;

  @override
  StarshipModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StarshipModel(
      name: fields[0] as String?,
      model: fields[1] as String?,
      manufacturer: fields[2] as String?,
      costInCredits: fields[3] as String?,
      length: fields[4] as String?,
      maxAtmospheringSpeed: fields[5] as String?,
      crew: fields[6] as String?,
      passengers: fields[7] as String?,
      cargoCapacity: fields[8] as String?,
      consumables: fields[9] as String?,
      hyperdriveRating: fields[10] as String?,
      mglt: fields[11] as String?,
      starshipClass: fields[12] as String?,
      films: (fields[13] as List?)?.cast<String>(),
      pilots: (fields[14] as List?)?.cast<String>(),
      url: fields[15] as String?,
      id: fields[16] as String?,
      image: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StarshipModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.model)
      ..writeByte(2)
      ..write(obj.manufacturer)
      ..writeByte(3)
      ..write(obj.costInCredits)
      ..writeByte(4)
      ..write(obj.length)
      ..writeByte(5)
      ..write(obj.maxAtmospheringSpeed)
      ..writeByte(6)
      ..write(obj.crew)
      ..writeByte(7)
      ..write(obj.passengers)
      ..writeByte(8)
      ..write(obj.cargoCapacity)
      ..writeByte(9)
      ..write(obj.consumables)
      ..writeByte(10)
      ..write(obj.hyperdriveRating)
      ..writeByte(11)
      ..write(obj.mglt)
      ..writeByte(12)
      ..write(obj.starshipClass)
      ..writeByte(13)
      ..write(obj.films)
      ..writeByte(14)
      ..write(obj.pilots)
      ..writeByte(15)
      ..write(obj.url)
      ..writeByte(16)
      ..write(obj.id)
      ..writeByte(17)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarshipModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
