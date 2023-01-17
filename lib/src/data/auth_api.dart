import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoer/src/models/index.dart';

class AuthApi {
  const AuthApi({required this.auth});

  final FirebaseAuth auth;

  Future<AppUser> createUser({required String displayName ,required String email, required String password}) async {
    final UserCredential credentials = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = credentials.user!;
    await user.updateDisplayName(displayName);
    return AppUser(
      uid: user.uid,
      email: email,
      displayName: displayName,
    );
  }

  Future<AppUser> login({required String email, required String password}) async {
    final UserCredential credentials = await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = credentials.user!;
    return AppUser(
      uid: user.uid,
      email: email,
      displayName: user.displayName!,
    );
  }

  Future<void> logout() async {
    await auth.signOut();
  }

}
