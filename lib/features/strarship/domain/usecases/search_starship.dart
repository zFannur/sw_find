import 'package:sw_finder/core/usecases/usecases.dart';
import 'package:sw_finder/core/errors/failures.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/repositories/starship_repository.dart';

class SearchStarship implements UseCase<List<Starship>, Query> {
  final StarshipRepository? repository;

  SearchStarship(this.repository);

  @override
  Future<List<Starship>> call(Query query) async {
    if (query.name == null) {
      throw InvalidTextError();
    }
    return await repository!.searchStarship(query.pageNumber, query.name);
  }
}

class Query {
  final int? pageNumber;
  final String? name;

  Query({required this.name, required this.pageNumber});

  List<Object?> get props => [name, pageNumber];
}