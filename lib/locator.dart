import 'package:get_it/get_it.dart';
import 'package:testproject/services/fake_auth_service.dart';
import 'package:testproject/services/firebase_auth_service.dart';
import 'package:testproject/services/firestore_db_service.dart';

import 'repository/user_repository.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
  // locator.registerLazySingleton(() => FirebaseStorageService());
}
