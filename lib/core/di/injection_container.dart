import 'package:WardrobePlus/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:WardrobePlus/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:WardrobePlus/features/auth/domain/repositories/auth_repository.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/login_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/register_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/reset_password.dart';
import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/data/datasource/firebase_wardrobe_datasource.dart';
import 'package:WardrobePlus/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';
import 'package:WardrobePlus/features/wardrobe/domain/repositories/wardrobe_repository.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/save_wardrobe_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //datasource
  sl.registerLazySingleton(
    () => FirebaseAuthDatasource(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ),
  );
  sl.registerLazySingleton(
    () => FirebaseWardrobeDatasource(FirebaseFirestore.instance),
  );

  //repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<WardrobeRepository>(
    () => WardrobeRepositoryImpl(sl()),
  );

  //usecases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => SaveWardrobeItem(sl()));

  //bloc
  sl.registerLazySingleton(
    () => AuthBloc(loginUser: sl(), registerUser: sl(), resetPassword: sl()),
  );
}
