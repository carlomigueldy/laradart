abstract class RestfulWebService<Model> {
  Future<List<Model>> all();
  Future<Model> findById({int id});
  Future<Model> create({Model data});
  Future<Model> update({Model data, int id});
  Future<Model> delete({int id});
  Future<Model> deletePermanently({int id});
  Future<Model> restore({int id});
}
