import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthDatasource(this.firebaseAuth, this.firestore);
  
  Future<void> registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'name': name,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
