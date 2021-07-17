import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSigninService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  static Future<GoogleSignInAccount?> signInGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      final googleAuth = await account?.authentication;
      final verifyToken = Uri.parse("http://10.0.2.2:4321/google");
      await http.post(verifyToken,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({'tokenId': googleAuth?.idToken}));
      return account;
    } catch (e) {
      print("error signin ---> $e");
    }
  }

  static Future signout() async {
    await _googleSignIn.signOut();
  }
}
