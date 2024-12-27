import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/datasource/remote/client/cats_api_client.dart';
import 'package:todo_app/app/data/entities/cat_entity.dart';
import 'package:todo_app/app/data/repository/cat_repository.dart';

@Injectable(as: CatRepository)
class CatRepositoryImpl extends CatRepository {
  final CatsApiClient catApiClient;

  CatRepositoryImpl({
    required this.catApiClient,
  });

  @override
  Future<Cat> oneMoreFactPlease() async {
    try {
      return await catApiClient.randomFact();
    } catch (e) {
      print("An error retrieving cat: ${e.toString()}");
      rethrow;
    }
  }
}