import 'package:sw_finder/core/usecases/usecases.dart';
import 'package:sw_finder/core/errors/failures.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/domain/repositories/people_repository.dart';

class SearchPeople implements UseCase<List<Person>, Query> {
  final PeopleRepository? repository;

  SearchPeople(this.repository);

  @override
  Future<List<Person>> call(Query query) async {
    if (query.name == null) {
      throw InvalidTextError();
    }
    return await repository!.searchPeople(query.pageNumber, query.name);
  }
}

class Query {
  final int? pageNumber;
  final String? name;

  Query({required this.name, required this.pageNumber});

  List<Object?> get props => [name, pageNumber];
}