import 'package:fire_library/models/user_entity.dart';

abstract class BaseAuthProvider {
  Future<bool> isUserSignedIn();

  UserEntity? currentUser();

  Future<UserEntity> login(String email, String password);

  Future<void> logout();
}
