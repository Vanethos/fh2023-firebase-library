import 'package:fire_library/models/user_entity.dart';
import 'package:fire_library/providers/auth/base_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider extends BaseAuthProvider {
  final FirebaseAuth auth;

  FirebaseAuthProvider(this.auth);

  @override
  UserEntity? currentUser() {
    final user = auth.currentUser;

    if (user == null) {
      return null;
    }

    return UserEntity(email: user.email, id: user.uid);
  }

  @override
  Future<bool> isUserSignedIn() async => currentUser() != null;

  @override
  Stream<UserEntity?> authStatus() => auth.authStateChanges().map(
        (user) => user?.uid != null
            ? UserEntity(email: user?.email, id: user!.uid)
            : null,
      );

  @override
  Future<UserEntity> login(String email, String password) async {
    final credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return UserEntity(email: credential.user?.email, id: credential.user!.uid);
  }

  @override
  Future<void> logout() => auth.signOut();
}
