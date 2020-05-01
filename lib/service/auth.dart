import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      print(result.user.uid);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
