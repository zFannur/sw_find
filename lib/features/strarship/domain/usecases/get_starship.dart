import 'package:sw_finder/core/usecases/usecases.dart';
import 'package:sw_finder/core/errors/failures.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/repositories/starship_repository.dart';

class GetStarship implements UseCase<List<Starship>, Params> {
  final StarshipRepository? repository;

  GetStarship(this.repository);

  @override
  Future<List<Starship>> call(Params params) async {
    if (params.number == null) {
      throw InvalidTextError();
    }
    return await repository!.getStarship(params.number);
  }
}

class Params {
  final int? number;

  Params({required this.number});

  List<Object?> get props => [number];
}
