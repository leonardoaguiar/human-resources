import "package:cloud_firestore/cloud_firestore.dart";
import "package:humanresources/app/shared/base_model.dart";

class Person extends BaseModel {
  String _documentId;
  String name;
  String surname;
  bool active;
  DateTime birthDate;

  Person();

  Person.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.name = document.data["name"];
    this.surname = document.data["surname"];
    this.active = document.data["active"] ?? false;
    Timestamp timestamp = document.data["birthDate"];
    this.birthDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  }

  @override
  toMap() {
    // TODO: implement toMap
    var map = new Map<String, dynamic>();
    map['name'] = this.name;
    map['surname'] = this.surname;
    map['active'] = this.active;
    map['birthDate'] = this.birthDate;
    return map;
  }

  @override
  String documentId() => _documentId;
}
