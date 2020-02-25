import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:humanresources/app/person/person_repository.dart';
import 'package:humanresources/app/app_module.dart';

class HomeBloc extends BlocBase {
  var _repository = AppModule.to.getDependency<PersonRepository>();
  get people => _repository.people;

  void delete(String documentId) => _repository.delete(documentId);

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
