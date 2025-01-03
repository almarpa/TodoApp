import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/datasource/remote/client/cats_api_client.dart';
import 'package:todo_app/app/data/repository/cat_repository.dart';
import 'package:todo_app/app/data/repository/impl/user_repository_impl.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_bloc.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() {
  $initGetIt(getIt);

  // getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // getIt.registerLazySingleton<CatsApiClient>(() => CatsApiClient(
  //       dio: getIt(),
  //       apiConfig: getIt(),
  //     ));

  // getIt.registerLazySingleton<UserRepository>(
  //     () => UserRepositoryImpl(firebaseAuth: getIt()));

  // getIt.registerLazySingleton<TaskBloc>(() => TaskBloc(
  //       getIt<CatRepository>(),
  //       getIt<UserRepository>(),
  //     ));
}
