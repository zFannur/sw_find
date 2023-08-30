import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sw_finder/core/config/app_config.dart';
import 'package:sw_finder/features/people/data/models/people_model.dart';
import 'package:sw_finder/core/config/http_routes.dart';

import 'package:sw_finder/core/errors/exceptions.dart';

abstract class PeopleRemoteDataSource {
  Future<List<PersonModel>> getPeople(int? pageNumber);
  Future<List<PersonModel>> searchPeople(int? pageNumber, String? name);
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final http.Client client;

  PeopleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getPeople(int? pageNumber) async {
    List<PersonModel> result = [];
    Map<String, dynamic>? jsonMap;
    Response response;

    response = await client
        .get(Uri.parse("${AppConfig.urlApi}/${HttpRoutes.GET_List_of_People}/${HttpRoutes.GET_Page}$pageNumber"));

    if (response.statusCode == 200) {
      jsonMap = json.decode(response.body);
      for (var person in jsonMap!['results']) {
        result.add(PersonModel.fromJson(person));
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PersonModel>> searchPeople(int? pageNumber, String? name) async {
    List<PersonModel> result = [];
    Map<String, dynamic>? jsonMap;
    Response response;

    response = await client
        .get(Uri.parse("${AppConfig.urlApi}/${HttpRoutes.GET_List_of_People}/${HttpRoutes.GET_Page}$pageNumber${HttpRoutes.SEARCH}$name"));

    if (response.statusCode == 200) {
      jsonMap = json.decode(response.body);
      for (var person in jsonMap!['results']) {
        result.add(PersonModel.fromJson(person));
      }
      return result;
    } else {
      throw ServerException();
    }
  }
}
