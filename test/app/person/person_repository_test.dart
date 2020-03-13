import 'package:flutter_test/flutter_test.dart';
import 'package:humanresources/app/models/person_model.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:humanresources/app/person/person_repository.dart';

class MockClient extends Mock implements Dio {}

void main() {
  PersonRepository repository;
  MockClient client;

  setUp(() {
    repository = PersonRepository();
    client = MockClient();
  });

  group('PersonRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<PersonRepository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => Response(data: {
                'documentID': 'jahskdhkasd',
                'name': 'Leo',
                'active': 'true',
                'birthDate': '17/01/1987'
              }, statusCode: 200));
      Stream<List<Person>> data = repository.people;
      expect(data.toList(), isNotEmpty);
    });
  });
}
