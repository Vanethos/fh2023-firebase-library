import 'package:fire_library/models/user_entity.dart';
import 'package:fire_library/providers/auth/base_auth_provider.dart';

class MockAuthProvider extends BaseAuthProvider {
  @override
  Future<bool> isUserSignedIn() async => true;

  @override
  UserEntity? currentUser() =>
      UserEntity(email: 'mock@email.com', id: 'banana-id');

  @override
  Stream<UserEntity?> authStatus() => Stream.value(
        UserEntity(email: 'mock@email.com', id: 'banana-id'),
      );

  @override
  Future<UserEntity> login(String email, String password) async =>
      UserEntity(email: email, id: 'email-id');

  @override
  Future<void> logout() async {}
}
