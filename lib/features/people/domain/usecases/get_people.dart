import 'package:sw_finder/core/usecases/usecases.dart';
import 'package:sw_finder/core/errors/failures.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/domain/repositories/people_repository.dart';

class GetPeople implements UseCase<List<Person>, Params> {
  final PeopleRepository? repository;

  GetPeople(this.repository);

  @override
  Future<List<Person>> call(Params params) async {
    if (params.number == null) {
      throw InvalidTextError();
    }
    return await repository!.getPeople(params.number);
  }
}

class Params {
  final int? number;

  Params({required this.number});

  List<Object?> get props => [number];
}
