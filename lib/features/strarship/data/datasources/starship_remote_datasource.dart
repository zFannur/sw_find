import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sw_finder/core/config/app_config.dart';
import 'package:sw_finder/core/config/http_routes.dart';
import 'package:sw_finder/core/errors/exceptions.dart';
import 'package:sw_finder/features/strarship/data/models/starship_model.dart';

abstract class StarshipRemoteDataSource {
  Future<List<StarshipModel>> getStarship(int? pageNumber);
  Future<List<StarshipModel>> searchStarship(int? pageNumber, String? name);
}

class StarshipRemoteDataSourceImpl implements StarshipRemoteDataSource {
  final http.Client client;

  StarshipRemoteDataSourceImpl({required this.client});

  @override
  Future<List<StarshipModel>> getStarship(int? pageNumber) async {
    List<StarshipModel> result = [];
    Map<String, dynamic>? jsonMap;
    Response response;

    response = await client
        .get(Uri.parse("${AppConfig.urlApi}/${HttpRoutes.GET_List_of_Starships}/${HttpRoutes.GET_Page}$pageNumber"));

    if (response.statusCode == 200) {
      jsonMap = json.decode(response.body);
      for (var person in jsonMap!['results']) {
        result.add(StarshipModel.fromJson(person));
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<StarshipModel>> searchStarship(int? pageNumber, String? name) async {
    List<StarshipModel> result = [];
    Map<String, dynamic>? jsonMap;
    Response response;

    response = await client
        .get(Uri.parse("${AppConfig.urlApi}/${HttpRoutes.GET_List_of_Starships}/${HttpRoutes.GET_Page}$pageNumber${HttpRoutes.SEARCH}$name"));

    if (response.statusCode == 200) {
      jsonMap = json.decode(response.body);
      for (var person in jsonMap!['results']) {
        result.add(StarshipModel.fromJson(person));
      }
      return result;
    } else {
      throw ServerException();
    }
  }
}
