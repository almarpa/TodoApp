import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @lazySingleton
  Dio provideDio() => Dio(BaseOptions(
        baseUrl: 'https://catfact.ninja/',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ));
}
