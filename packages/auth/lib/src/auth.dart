import 'dart:developer' as devtool;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show SupabaseClient;

class MyAuth {
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'phone',
    ],
  );
  final _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle({
    required SupabaseClient client,
  }) async {
    try {
      final googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = (await _auth.signInWithCredential(credential)).user;
      devtool.log('User: $user');

      if (user != null) {
        await insertUser(client: client, user: user);
      }
    } catch (e) {
      devtool.log('User Error: $e');
      throw Exception('Something went Wrong while sign in: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Error signing out');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      return user;
    } catch (e) {
      throw Exception('Error getting current user');
    }
  }

  Future<void> insertUser({required SupabaseClient client, User? user}) async {
    try {
      await client.from('users').insert({
        'uid': user!.uid,
        'email': user.email,
        'name': user.displayName,
        'phone': user.phoneNumber,
        'photo_url': user.photoURL,
        'last_sign_in': user.metadata.lastSignInTime.toString(),
        'created_at': user.metadata.creationTime.toString(),
        'updated_at': user.metadata.lastSignInTime.toString(),
      });
    } catch (e) {
      devtool.log(e.toString());
    }
  }
}
