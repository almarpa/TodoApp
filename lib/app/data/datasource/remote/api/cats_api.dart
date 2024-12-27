import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_app/app/data/entities/cat_entity.dart';

part 'cats_api.g.dart';

@RestApi(baseUrl: "https://catfact.ninja/")
abstract class CatsApi {
  factory CatsApi(Dio dio, {String baseUrl}) = _CatsApi;

  @GET("/fact")
  Future<Cat> randomFact();
}
