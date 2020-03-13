import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:humanresources/app/app_module.dart';
import 'package:humanresources/app/models/person_model.dart';
import "package:humanresources/app/person/person_repository.dart";
import 'package:rxdart/rxdart.dart';

class PersonBloc extends BlocBase {
  String _name;
  String _surname;
  DateTime _birthDate;
  bool _active;
  String _documentId;

  PersonBloc() {
    _birthDateController.listen((value) => _birthDate = value);
    _nameController.listen((value) => _name = value);
    _surnameController.listen((value) => _surname = value);
    _activeController.listen((value) => _active = value);
  }

  var _repository = AppModule.to.getDependency<PersonRepository>();

  void setPerson(Person person) {
    _documentId = person.documentId();
    setName(person.name);
    setSurname(person.surname);
    setActive(person.active);
    setBirthDate(person.birthDate);
  }

  var _birthDateController = BehaviorSubject<DateTime>();
  Stream<DateTime> get outBirthDate => _birthDateController.stream;

  var _nameController = BehaviorSubject<String>();
  Stream<String> get outName => _nameController.stream;

  var _surnameController = BehaviorSubject<String>();
  Stream<String> get outSurname => _surnameController.stream;

  var _activeController = BehaviorSubject<bool>();
  Stream<bool> get outActive => _activeController.stream;

  void setBirthDate(DateTime value) => _birthDateController.sink.add(value);

  void setActive(bool value) => _activeController.sink.add(value);

  void setName(String value) => _nameController.sink.add(value);

  void setSurname(String value) => _surnameController.sink.add(value);

  bool insertOrUpdate() {
    var person = Person()
      ..name = _name
      ..surname = _surname
      ..birthDate = _birthDate
      ..active = _active;

    if (_documentId?.isEmpty ?? true) {
      _repository.add(person);
    } else {
      _repository.update(_documentId, person);
    }

    return true;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _birthDateController.close();
    _activeController.close();
    _nameController.close();
    _surnameController.close();
    super.dispose();
  }
}
