import 'package:hive/hive.dart';
import 'package:sw_finder/features/strarship/domain/entities/starship.dart';

part 'starship_model.g.dart';

@HiveType(typeId: 1)
class StarshipModel extends Starship {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? model;
  @HiveField(2)
  String? manufacturer;
  @HiveField(3)
  String? costInCredits;
  @HiveField(4)
  String? length;
  @HiveField(5)
  String? maxAtmospheringSpeed;
  @HiveField(6)
  String? crew;
  @HiveField(7)
  String? passengers;
  @HiveField(8)
  String? cargoCapacity;
  @HiveField(9)
  String? consumables;
  @HiveField(10)
  String? hyperdriveRating;
  @HiveField(11)
  String? mglt;
  @HiveField(12)
  String? starshipClass;
  @HiveField(13)
  List<String>? films;
  @HiveField(14)
  List<String>? pilots;
  @HiveField(15)
  String? url;
  @HiveField(16)
  String? id;
  @HiveField(17)
  String? image;

  StarshipModel(
      {required this.name,
      required this.model,
      required this.manufacturer,
      required this.costInCredits,
      required this.length,
      required this.maxAtmospheringSpeed,
      required this.crew,
      required this.passengers,
      required this.cargoCapacity,
      required this.consumables,
      required this.hyperdriveRating,
      required this.mglt,
      required this.starshipClass,
      required this.films,
      required this.pilots,
      required this.url,
      required this.id,
      required this.image})
      : super(
            name: name,
            model: model,
            manufacturer: manufacturer,
            costInCredits: costInCredits,
            length: length,
            maxAtmospheringSpeed: maxAtmospheringSpeed,
            crew: crew,
            passengers: passengers,
            cargoCapacity: cargoCapacity,
            consumables: consumables,
            hyperdriveRating: hyperdriveRating,
            mglt: mglt,
            starshipClass: starshipClass,
            films: films,
            pilots: pilots,
            url: url,
            id: id,
            image: image);

  factory StarshipModel.fromJson(Map<String, dynamic> json) => StarshipModel(
        name: json["name"],
        model: json["model"],
        manufacturer: json["manufacturer"],
        costInCredits: json["cost_in_credits"],
        length: json["length"],
        maxAtmospheringSpeed: json["max_atmosphering_speed"],
        crew: json["crew"],
        passengers: json["passengers"],
        cargoCapacity: json["cargo_capacity"],
        consumables: json["consumables"],
        hyperdriveRating: json["hyperdrive_rating"],
        mglt: json["MGLT"],
        starshipClass: json["starship_class"],
        films: json["films"] != null
            ? List<String>.from(json["films"].map((x) => x))
            : [],
        pilots: json["pilots"] != null
            ? List<String>.from(json["pilots"].map((x) => x))
            : [],
        url: json["url"],
        id: json['url']
            .toString()
            .split("/")[json['url'].toString().split("/").length - 2],
        image:
            "assets/starships/${json['url'].toString().split("/")[json['url'].toString().split("/").length - 2]}.png",
      );

  factory StarshipModel.fromMap(Map<String, dynamic> json) => StarshipModel(
        name: json['name'],
        model: json['model'],
        manufacturer: json['manufacturer'],
        costInCredits: json['cost_in_credits'],
        length: json['length'],
        maxAtmospheringSpeed: json['max_atmosphering_speed'],
        crew: json['crew'],
        passengers: json['passengers'],
        cargoCapacity: json['cargo_capacity'],
        consumables: json['consumables'],
        hyperdriveRating: json['hyperdrive_rating'],
        mglt: json['MGLT'],
        starshipClass: json['starship_class'],
        films: json["films"] != null
            ? List<String>.from(json["films"].map((x) => x))
            : [],
        pilots: json["pilots"] != null
            ? List<String>.from(json["pilots"].map((x) => x))
            : [],
        url: json['url'],
        id: json['id'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['model'] = this.model;
    data['manufacturer'] = this.manufacturer;
    data['cost_in_credits'] = this.costInCredits;
    data['length'] = this.length;
    data['max_atmosphering_speed'] = this.maxAtmospheringSpeed;
    data['crew'] = this.crew;
    data['passengers'] = this.passengers;
    data['cargo_capacity'] = this.cargoCapacity;
    data['consumables'] = this.consumables;
    data['hyperdrive_rating'] = this.hyperdriveRating;
    data['MGLT'] = this.mglt;
    data['starship_class'] = this.starshipClass;
    data['pilots'] = this.pilots.toString();
    data['films'] = this.films.toString();
    data['url'] = this.url;
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }

  static StarshipModel toStarshipModel(Starship starship) => StarshipModel(
        name: starship.name,
        model: starship.model,
        manufacturer: starship.manufacturer,
        costInCredits: starship.costInCredits,
        length: starship.length,
        maxAtmospheringSpeed: starship.maxAtmospheringSpeed,
        crew: starship.crew,
        passengers: starship.passengers,
        cargoCapacity: starship.cargoCapacity,
        consumables: starship.consumables,
        hyperdriveRating: starship.hyperdriveRating,
        mglt: starship.mglt,
        starshipClass: starship.starshipClass,
        films: starship.films,
        pilots: starship.pilots,
        url: starship.url,
        id: starship.id,
        image: starship.image,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarshipModel && runtimeType == other.runtimeType;
}
