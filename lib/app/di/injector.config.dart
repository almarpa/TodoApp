// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/datasource/remote/client/cats_api_client.dart' as _i7;
import '../data/datasource/remote/config/api_config.dart' as _i3;
import '../data/datasource/remote/config/cats_api_config.dart' as _i4;
import '../data/repository/cat_repository.dart' as _i5;
import '../data/repository/impl/cat_repository_impl.dart' as _i6;
import 'dio_module.dart' as _i9;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioModule = _$DioModule();
  gh.factory<_i3.ApiConfig>(() => _i4.CatsApiConfig());
  gh.factory<_i5.CatRepository>(
      () => _i6.CatRepositoryImpl(catApiClient: gh<_i7.CatsApiClient>()));
  gh.singleton<_i8.Dio>(() => dioModule.dio(gh<_i3.ApiConfig>()));
  gh.factory<_i7.CatsClient>(() => _i7.CatsApiClient(
        dio: gh<_i8.Dio>(),
        apiConfig: gh<_i3.ApiConfig>(),
      ));
  return getIt;
}

class _$DioModule extends _i9.DioModule {}
