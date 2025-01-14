import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_app/app/data/entities/cat_entity.dart';

part 'cats_api.g.dart';

@RestApi()
abstract class CatsApi {
  factory CatsApi(Dio dio) = _CatsApi;

  @GET("/fact")
  Future<CatEntity> randomFact();
}
