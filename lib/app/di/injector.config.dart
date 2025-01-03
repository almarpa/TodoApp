// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:dio/dio.dart' as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/datasource/remote/client/cats_api_client.dart' as _i8;
import '../data/repository/cat_repository.dart' as _i9;
import '../data/repository/impl/cat_repository_impl.dart' as _i10;
import '../data/repository/impl/user_repository_impl.dart' as _i7;
import '../data/repository/user_repository.dart' as _i6;
import '../presentation/screens/home/bloc/task_bloc.dart' as _i11;
import 'api_module.dart' as _i12;
import 'firebase_module.dart' as _i13;

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
  final apiModule = _$ApiModule();
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.Dio>(() => apiModule.provideDio());
  gh.factory<_i4.FirebaseAuth>(() => firebaseModule.auth);
  gh.factory<_i5.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i6.UserRepository>(
      () => _i7.UserRepositoryImpl(gh<_i4.FirebaseAuth>()));
  gh.factory<_i8.CatsClient>(() => _i8.CatsApiClient(gh<_i3.Dio>()));
  gh.factory<_i9.CatRepository>(
      () => _i10.CatRepositoryImpl(gh<_i8.CatsClient>()));
  gh.factory<_i11.TaskBloc>(() => _i11.TaskBloc(
        gh<_i9.CatRepository>(),
        gh<_i6.UserRepository>(),
      ));
  return getIt;
}

class _$ApiModule extends _i12.ApiModule {}

class _$FirebaseModule extends _i13.FirebaseModule {}
