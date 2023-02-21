import 'package:fire_library/models/user_entity.dart';

abstract class BaseAuthProvider {
  Future<bool> isUserSignedIn();

  UserEntity? currentUser();

  Stream<UserEntity?> authStatus();

  Future<UserEntity> login(String email, String password);

  Future<void> logout();
}
