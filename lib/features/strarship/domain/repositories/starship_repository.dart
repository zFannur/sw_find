
import 'package:sw_finder/features/strarship/domain/entities/starship.dart';

abstract class StarshipRepository {
  Future<List<Starship>> getStarship(int? pageNumber);
  Future<List<Starship>> searchStarship(int? pageNumber, String? name);

  void addStarship(Starship starship);
  List<Starship> getAllStarship();
  void deleteStarshipId(int id);
}
