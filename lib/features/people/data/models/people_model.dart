import 'package:hive/hive.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';

part 'people_model.g.dart';

@HiveType(typeId: 0)
class PersonModel extends Person {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? height;
  @HiveField(2)
  String? mass;
  @HiveField(3)
  String? hairColor;
  @HiveField(4)
  String? skinColor;
  @HiveField(5)
  String? eyeColor;
  @HiveField(6)
  String? birthYear;
  @HiveField(7)
  String? gender;
  @HiveField(8)
  String? homeworld;
  @HiveField(9)
  List<String>? films;
  @HiveField(10)
  List<String>? species;
  @HiveField(11)
  List<String>? vehicles;
  @HiveField(12)
  List<String>? starships;
  @HiveField(13)
  String? url;
  @HiveField(14)
  String? id;
  @HiveField(15)
  String? image;

  PersonModel(
      {
      required this.name,
      required this.height,
      required this.mass,
      required this.hairColor,
      required this.skinColor,
      required this.eyeColor,
      required this.birthYear,
      required this.gender,
      required this.homeworld,
      required this.films,
      required this.species,
      required this.vehicles,
      required this.starships,
      required this.url,
      required this.id,
      required this.image})
      : super(
            name: name,
            height: height,
            mass: mass,
            hairColor: hairColor,
            skinColor: skinColor,
            eyeColor: eyeColor,
            birthYear: birthYear,
            gender: gender,
            homeworld: homeworld,
            films: films,
            species: species,
            vehicles: vehicles,
            starships: starships,
            url: url,
            id: id,
            image: image);

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"] ?? "",
        gender: json["gender"] ?? "",
        homeworld: json["homeworld"]
            .toString()
            .split("/")[json['homeworld'].toString().split("/").length - 2],
        films: json["films"] != null
            ? List<String>.from(json["films"].map((x) => x))
            : [],
        species: json["species"] != null
            ? List<String>.from(json["species"].map((x) => x))
            : [],
        vehicles: json["vehicles"] != null
            ? List<String>.from(json["vehicles"].map((x) => x))
            : [],
        starships: json["starships"] != null
            ? List<String>.from(json["starships"].map((x) => x))
            : [],
        url: json["url"],
        id: json['url']
            .toString()
            .split("/")[json['url'].toString().split("/").length - 2],
        image:
            "assets/characters/${json['url'].toString().split("/")[json['url'].toString().split("/").length - 2]}.png",
      );

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'height': height,
      'mass': mass,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'eyeColor': eyeColor,
      'birthYear': birthYear,
      'homeworld': homeworld,
      'films': films.toString(),
      'species': species.toString(),
      'vehicles': vehicles.toString(),
      'starships': starships.toString(),
      'url': url,
      'id': id,
      'image': image
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> json) => PersonModel(
    name: json['name'],
    height: json['height'],
    mass: json['mass'],
    hairColor: json['hair_color'],
    skinColor: json['skin_color'],
    eyeColor: json['eye_color'],
    birthYear: json['birth_year'],
    gender: json['gender'],
    homeworld: json['homeworld'],
    films: json["films"] != null
        ? List<String>.from(json["films"].map((x) => x))
        : [],
    species: json["species"] != null
        ? List<String>.from(json["species"].map((x) => x))
        : [],
    vehicles: json["vehicles"] != null
        ? List<String>.from(json["vehicles"].map((x) => x))
        : [],
    starships: json["starships"] != null
        ? List<String>.from(json["starships"].map((x) => x))
        : [],
    url: json['url'],
    id: json['id'],
    image: json['image'],
  );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['height'] = this.height;
    data['mass'] = this.mass;
    data['hair_color'] = this.hairColor;
    data['skin_color'] = this.skinColor;
    data['eye_color'] = this.eyeColor;
    data['birth_year'] = this.birthYear;
    data['gender'] = this.gender;
    data['homeworld'] = this.homeworld;
    data['films'] = this.films.toString();
    data['species'] = this.films.toString();
    data['vehicles'] = this.films.toString();
    data['starships'] = this.films.toString();
    data['url'] = this.url;
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }

  static PersonModel toPersonModel(Person person) => PersonModel(
      name: person.name,
      height: person.height,
      mass: person.mass,
      hairColor: person.hairColor,
      skinColor: person.skinColor,
      eyeColor: person.eyeColor,
      birthYear: person.birthYear,
      gender: person.gender,
      homeworld: person.homeworld,
      films: person.films ?? [],
      species: person.species ?? [],
      vehicles: person.vehicles ?? [],
      starships: person.starships ?? [],
      url: person.url,
      id: person.id,
      image: person.image,
    );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonModel && runtimeType == other.runtimeType;
}
