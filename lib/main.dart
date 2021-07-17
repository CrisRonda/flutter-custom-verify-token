import 'package:auth_app/services/google_signin_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleSignInAccount? user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              user == null ? 'Custom Auth' : "Bienvenido ${user!.displayName}"),
          actions: [
            user == null
                ? SizedBox.shrink()
                : IconButton(
                    onPressed: () async {
                      await GoogleSigninService.signout();
                      setState(() {
                        this.user = null;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.signOutAlt))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [user == null ? authWidget() : Text("Auth success")],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton authWidget() {
    return MaterialButton(
      color: Colors.red,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () async {
        final userAuth = await GoogleSigninService.signInGoogle();
        if (userAuth == null) {
          final snackBar = SnackBar(content: Text('Ups! An error occurred.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          setState(() {
            this.user = userAuth;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
            SizedBox(
              width: 24,
            ),
            Text(
              "Sigin with Google",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
