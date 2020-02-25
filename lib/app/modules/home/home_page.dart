import 'package:flutter/material.dart';
import 'package:humanresources/app/models/person_model.dart';
import 'package:humanresources/app/modules/home/home_bloc.dart';
import 'package:humanresources/app/person/person/person_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _bloc = HomeBloc();

  var _dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Human Resources"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            var person = Person()
              ..active = true
              ..birthDate = DateTime.now()
              ..name = "";

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonPage(person)),
            );
          },
        ),
        body: Container(
          child: StreamBuilder<List<Person>>(
            stream: _bloc.people,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              return Container(
                child: ListView(
                  children: snapshot.data.map((person) {
                    return Dismissible(
                      key: Key(person.documentId()),
                      onDismissed: (direction) {
                        _bloc.delete(person.documentId());
                      },
                      child: ListTile(
                        title: Text(person.name),
                        subtitle: Text(_dateFormat.format(person.birthDate)),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonPage(person)),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ));
  }
}
