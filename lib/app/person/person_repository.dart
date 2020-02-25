import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humanresources/app/models/person_model.dart';

class PersonRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('people');

  void add(Person person) => _collection.add(person.toMap());

  void update(String documentId, Person person) =>
      _collection.document(documentId).updateData(person.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<Person>> get people =>
      _collection.snapshots().map((query) => query.documents
          .map<Person>((document) => Person.fromMap(document))
          .toList());

  // Observable<List<Person>> get people =>
  //     Observable(_collection.snapshots().map((query) => query.documents
  //         .map<Person>((document) => Person.fromMap(document))
  //         .toList()));

  //dispose will be called automatically
  @override
  void dispose() {}
}
