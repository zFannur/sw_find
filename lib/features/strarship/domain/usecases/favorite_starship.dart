import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/repositories/starship_repository.dart';

class FavoriteStarship {
  final StarshipRepository? repository;

  FavoriteStarship(this.repository);

  void addStarship(Starship starship) {
    repository!.addStarship(starship);
  }
  List<Starship> getAllStarship() {
    return repository!.getAllStarship();
  }

  List<String> get getFavoriteId {
    return repository!.getAllStarship().map((e) => e.id ?? '').toList();
  }

  void deleteStarshipId(int id) {
    repository!.deleteStarshipId(id);
  }
}