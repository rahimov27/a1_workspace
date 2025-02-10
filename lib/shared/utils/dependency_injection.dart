import 'package:a1_workspace/features/login/presentation/bloc/bloc/auth_bloc.dart';
import 'package:a1_workspace/features/login/services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:a1_workspace/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:a1_workspace/features/home/data/repositories/home_repository_impl.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/calendar/data/datasources/remote/calendar_remote_datasource.dart';
import 'package:a1_workspace/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/service/data/datasources/remote/client_remote_datasources.dart';
import 'package:a1_workspace/features/service/data/repositories/client_repository_impl.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  // Регистрация Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerFactory<AuthBloc>(()=> AuthBloc(repo: FirebaseAuthService()));

  // Регистрация репозиториев
  getIt.registerLazySingleton<HomeRepositoryImpl>(
    () => HomeRepositoryImpl(
        remoteDatasource: HomeRemoteDatasourceImpl(dio: getIt())),
  );
  getIt.registerLazySingleton<CalendarRepositoryImpl>(
    () => CalendarRepositoryImpl(
        remoteDatasource: CalendarRemoteDatasourceImpl(dio: getIt())),
  );
  getIt.registerLazySingleton<ClientRepositoryImpl>(
    () => ClientRepositoryImpl(
        remoteDatasource: ClientRemoteDatasourceImpl(dio: getIt())),
  );

  // Регистрация BLoCs
  getIt.registerFactory<HomeBloc>(
      () => HomeBloc(repository: getIt<HomeRepositoryImpl>()));
  getIt.registerFactory<CalendarBloc>(
      () => CalendarBloc(repository: getIt<CalendarRepositoryImpl>()));
  getIt.registerFactory<ClientBloc>(
      () => ClientBloc(repository: getIt<ClientRepositoryImpl>()));
}
