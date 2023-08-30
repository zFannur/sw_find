import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/domain/repositories/people_repository.dart';

class FavoritePeople {
  final PeopleRepository? repository;

  FavoritePeople(this.repository);

  void addPerson(Person person) {
    repository!.addPerson(person);
  }
  List<Person> getAllPerson() {
    return repository!.getAllPerson();
  }

  List<String> get getFavoriteId {
    return repository!.getAllPerson().map((e) => e.id ?? '').toList();
  }

  void deletePersonId(int id) {
    repository!.deletePersonId(id);
  }
}