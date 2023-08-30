import 'package:sw_finder/core/network/network_info.dart';
import 'package:sw_finder/core/errors/exceptions.dart';
import 'package:sw_finder/core/errors/failures.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/repositories/starship_repository.dart';
import 'package:sw_finder/features/strarship/data/datasources/starship_local_datasource.dart';
import 'package:sw_finder/features/strarship/data/datasources/starship_remote_datasource.dart';
import 'package:sw_finder/features/strarship/data/models/starship_model.dart';

class StarshipRepositoryImpl implements StarshipRepository {
  final StarshipRemoteDataSource? starshipRemoteDataSource;
  final StarshipLocalDataSource? starshipLocalDataSource;
  final NetworkInfo? networkInfo;

  StarshipRepositoryImpl({
    required this.starshipRemoteDataSource,
    required this.starshipLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Starship>> getStarship(int? pageNumber) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListOfStarship =
            await starshipRemoteDataSource!.getStarship(pageNumber);
        return remoteListOfStarship;
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
  Future<List<Starship>> searchStarship(int? pageNumber, String? name) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListOfStarship =
            await starshipRemoteDataSource!.searchStarship(pageNumber, name);
        return remoteListOfStarship;
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
  void addStarship(Starship starship) {
    try {
      starshipLocalDataSource!.addStarship(StarshipModel.toStarshipModel(starship));
    } on CacheException {
      throw CacheFailure();
    }
  }

  @override
  List<Starship> getAllStarship() {
    try {
      final localStarshipList = starshipLocalDataSource!.getAllStarship();
      return localStarshipList;
    } on CacheException {
      throw CacheFailure();
    }
  }
  @override
  void deleteStarshipId(int id) {
    try {
      starshipLocalDataSource!.deleteStarshipId(id);
    } on CacheException {
      throw CacheFailure();
    }
  }
}
