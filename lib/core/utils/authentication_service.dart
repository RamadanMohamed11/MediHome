import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medihome/core/errors/failures.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;

  void storeUser(UserCredential userCredential, String name, String email) {
    UserModel user = UserModel(
      id: userCredential.user!.uid,
      email: email,
      name: name,
    );
    _usersCollection.doc(user.id).set(user.toJson());
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    storeUser(userCredential, name, email);
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userDoc = await _usersCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    if (userDoc.exists) {
      return UserModel.fromSnap(userDoc);
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  Future<void> forgetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error sending password reset email: $e");
    }
  }

  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '320834603461-51phhq60u6lnf820qauiriobus3d9bpm.apps.googleusercontent.com',
      );
    }
    isInitialize = true;
  }

  // Sign in with Google
  Future<UserModel?> signInWithGoogle(BuildContext context) async {
    try {
      initSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile'],
        );
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;
      late UserModel? userModel;
      if (user != null) {
        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'id': user.uid,
            'name': user.displayName ?? '',
            'email': user.email ?? '',
          });
        }
        userModel = UserModel.fromSnap(docSnapshot);
      }
      return userModel;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        GoRouter.of(context).go(AppRouter.kLogin);
        print("User canceled Google Sign-In");
        return null; // 👈 just return null gracefully
      }
      rethrow; // other Google Sign-In errors
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // // Get current user
  // UserModel getCurrentUser() {
  //   User? user = _firebaseAuth.currentUser;
  //   UserModel userModel = UserModel.fromSnap(  );
  //   return userModel;
  // }

  // Future<User?> signInWithGoogle() async {
  //   // Trigger Google Sign-In dialog
  //   final googleUser = await _googleSignIn.signIn();
  //   if (googleUser == null) return null; // User cancelled

  //   final googleAuth = await googleUser.authentication;

  //   // Create new credential for Firebase
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   // Sign in to Firebase
  //   final userCredential = await _firebaseAuth.signInWithCredential(credential);
  //   return userCredential.user;
  // }
}
