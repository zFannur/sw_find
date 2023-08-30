import 'package:sw_finder/features/people/domain/entities/person.dart';

abstract class PeopleRepository {
  Future<List<Person>> getPeople(int? pageNumber);
  Future<List<Person>> searchPeople(int? pageNumber, String? name);

  void addPerson(Person person);
  List<Person> getAllPerson();
  void deletePersonId(int id);
}
