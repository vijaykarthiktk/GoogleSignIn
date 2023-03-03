import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Google Sign In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleSignIn _googleSignIn;
  late FirebaseAuth _auth;
  String _email ="";
  String _username = "";
  String _image = "";
  String _id = "";

@override
initState()  {
    // TODO: implement initState
  Firebase.initializeApp().whenComplete(() {
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
  });

  }

  signInWithGoogle() async {
  _googleSignIn.signOut();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    googleSignInAccount?.clearAuthCache();
    GoogleSignInAuthentication? googleSignInAuthentication =  await googleSignInAccount?.authentication;
    setState(() {
      _email = (googleSignInAccount?.email)!;
      _username = (googleSignInAccount?.displayName)!;
      _image = (googleSignInAccount?.photoUrl)!;
      _id = (googleSignInAccount?.id)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(_image),
            Text(_email),
            Text(_username),
            Text(_id),
            FilledButton(onPressed: (){
              signInWithGoogle();
            }, child: Text("Sign In "))
          ],
        ),
      ),
    );
  }
}
