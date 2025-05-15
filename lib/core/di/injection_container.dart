import 'package:WardrobePlus/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:WardrobePlus/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:WardrobePlus/features/auth/domain/repositories/auth_repository.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/login_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/register_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/reset_password.dart';
import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/data/datasource/supabase_wardrobe_datasource.dart';
import 'package:WardrobePlus/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';
import 'package:WardrobePlus/features/wardrobe/domain/repositories/wardrobe_repository.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/load_wardrobe_items.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/save_wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final supabaseClient = Supabase.instance.client;

  //datasource
  sl.registerLazySingleton(() => SupabaseAuthDatasource(supabaseClient));
  sl.registerLazySingleton(() => SupabaseWardrobeDatasource(supabaseClient));

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
  sl.registerLazySingleton(() => LoadWardrobeItems(sl()));

  //bloc
  sl.registerLazySingleton(
    () => AuthBloc(loginUser: sl(), registerUser: sl(), resetPassword: sl()),
  );
  sl.registerLazySingleton(
    () => WardrobeBloc(
      saveWardrobeItem: sl<SaveWardrobeItem>(),
      loadWardrobeItems: sl<LoadWardrobeItems>(),
    ),
  );
}
