import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:humanresources/app/person/person/person_bloc.dart';
import 'package:humanresources/app/app_module.dart';

void main() {
  initModule(AppModule());
  PersonBloc bloc;

  setUp(() {
    bloc = AppModule.to.bloc<PersonBloc>();
  });

  group('PersonBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<PersonBloc>());
    });
  });
}
