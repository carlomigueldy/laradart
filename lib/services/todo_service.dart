import 'package:laradart/datamodels/user.dart';
import 'package:laradart/services/abstract/restful_service.dart';

class TodoService implements RestfulWebService<User> {
  @override
  Future<List<User>> all() {
    // TODO: implement all
    throw UnimplementedError();
  }

  @override
  Future<User> create({User data}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<User> delete({int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<User> deletePermanently({int id}) {
    // TODO: implement deletePermanently
    throw UnimplementedError();
  }

  @override
  Future<User> findById({int id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<User> restore({int id}) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  Future<User> update({User data, int id}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
