import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/datasource/remote/api/cats_api.dart';

abstract class CatsClient {
  Future<dynamic> randomFact();
}

@Injectable(as: CatsClient)
class CatsApiClient extends CatsClient {
  final Dio dio;
  final CatsApi api;

  @override
  Future<dynamic> randomFact() {
    return api.randomFact();
  }

  CatsApiClient(this.dio) : api = CatsApi(dio);
}
