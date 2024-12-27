import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/datasource/remote/config/api_config.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(ApiConfig config) {
    Dio dio = Dio();
    dio.options.headers = config.headers;
    return dio;
  }
}
