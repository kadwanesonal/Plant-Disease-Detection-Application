// import 'package:flutter/material.dart';
// import 'profile_page.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginPage extends MaterialPageRoute<Null> {
//   LoginPage()
//       : super(builder: (BuildContext context) {
//           return Scaffold(
//             body: SingleChildScrollView(
//                 child: Column(children: <Widget>[
//               Column(
//                 children: [
//                   ///top heading
//                   Container(
//                     margin: EdgeInsets.symmetric(),
//                     child: Text('LOG IN.',
//                         style: TextStyle(
//                             fontSize: 31.0,
//                             height: 1.3,
//                             fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center),
//                   ),

//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: ElevatedButton(
//                       child: Text(
//                         'Log in',
//                         style: TextStyle(fontSize: 15.0),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           primary: Colors.green[300],
//                           padding: EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 125.0)),
//                       onPressed: () {
//                         Navigator.push(context, ProfilePage());
//                       },
//                     ),
//                   ),
//                 ],
//               )
//             ])),
//           );
//         });
// }



// // Google Sign In Functionality
// class GoogleLoginApp extends StatefulWidget {
//   const GoogleLoginApp({ Key? key }) : super(key: key);

//   @override
//   _GoogleLoginAppState createState() => _GoogleLoginAppState();
// }

// class _GoogleLoginAppState extends State<GoogleLoginApp> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   @override
//   Widget build(BuildContext context) {
//     GoogleSignInAccount? user = _googleSignIn.currentUser;

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Google Demo (Logged ' + (user == null ? 'out' : 'in') + ')'),
//         ), // AppBar
//         body: Center(
//           child: Column(
//             children: [
//               ElevatedButton(child: Text('Sign In'),
//               onPressed: user != null ? null : () async {
//                 await _googleSignIn.signIn();
//                 setState(() {});
//               }),
//               ElevatedButton(child: Text('Sign Out'),
//               onPressed: user == null ? null : () async {
//                 await _googleSignIn.signOut();
//                 setState(() {});
//               }),
//             ],
//           ), // Column
//         ),
//       ),
//     );
//   }
// }