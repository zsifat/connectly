import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser(){return _auth.currentUser;}
  

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code.toString());

    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential?> signUp(String email, String password) async {
    UserCredential? usercred= await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return usercred;
  }

  void passwordReset(String email) async{
    await _auth.sendPasswordResetEmail(email: email);
  }

  void sendEmailVerification(User user) async{
    await user.sendEmailVerification();
  }
}
