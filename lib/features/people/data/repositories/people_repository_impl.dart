import 'package:sw_finder/features/people/data/models/people_model.dart';
import 'package:sw_finder/features/people/domain/repositories/people_repository.dart';
import 'package:sw_finder/core/network/network_info.dart';
import 'package:sw_finder/features/people/data/datasources/people_local_datasource.dart';
import 'package:sw_finder/features/people/data/datasources/people_remote_datasource.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/core/errors/exceptions.dart';
import 'package:sw_finder/core/errors/failures.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource? peopleRemoteDataSource;
  final PeopleLocalDataSource? peopleLocalDataSource;
  final NetworkInfo? networkInfo;

  PeopleRepositoryImpl({
    required this.peopleRemoteDataSource,
    required this.peopleLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Person>> getPeople(int? pageNumber) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListOfPeople =
            await peopleRemoteDataSource!.getPeople(pageNumber);
        return remoteListOfPeople;
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      try {
        throw CacheFailure();
      } on CacheException {
        throw CacheFailure();
      }
    }
  }

  @override
  Future<List<Person>> searchPeople(int? pageNumber, String? name) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListOfPeople =
            await peopleRemoteDataSource!.searchPeople(pageNumber, name);
        return remoteListOfPeople;
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      try {
        throw ServerFailure();
      } on CacheException {
        throw CacheFailure();
      }
    }
  }

  @override
  void addPerson(Person person) {
    try {
      peopleLocalDataSource!.addPerson(PersonModel.toPersonModel(person));
    } on CacheException {
      throw CacheFailure();
    }
  }

  @override
  List<Person> getAllPerson() {
    try {
      final localPersonList = peopleLocalDataSource!.getAllPerson();
      return localPersonList;
    } on CacheException {
      throw CacheFailure();
    }
  }
  @override
  void deletePersonId(int id) {
    try {
      peopleLocalDataSource!.deletePersonId(id);
    } on CacheException {
      throw CacheFailure();
    }
  }
}
