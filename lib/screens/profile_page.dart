import 'package:flutter/material.dart';
import 'search_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePage extends StatefulWidget {
  final String? username, photoUrl, email;
  final VoidCallback callbackLogOut;
  const ProfilePage(
      this.username, this.photoUrl, this.email, this.callbackLogOut,
      {Key? key})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  getProfileImage() {
    if (widget.photoUrl != null) {
      return NetworkImage("${widget.photoUrl}");
    } else {
      return const AssetImage('assets/hero_image.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    // GoogleSignInAccount? user = _googleSignIn.currentUser;
    getProfileImage();

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await _googleSignIn.signOut();
      //     setState(() {});
      //     Navigator.pop(context);
      //   },
      //   child: Icon(Icons.logout),
      //   backgroundColor: Colors.green[900],
      // ),
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.green[300],
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                widget.callbackLogOut();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        //Container(
        ///PROFILE PAGE HEADING
        //   margin: EdgeInsets.only(left: 0, top: 100, right: 95, bottom: 2),
        //   child: Text(
        //     'PROFILE PAGE',
        //     style: TextStyle(
        //         fontSize: 31.0, height: 1.3, fontWeight: FontWeight.bold),
        //   ),
        // ),

        SizedBox(height: 40.0),
        CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.white,
          backgroundImage: getProfileImage(),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          child: Text(
            widget.username != null ? '${widget.username}' : 'Anonymous',
            style: TextStyle(
              fontSize: 20.0,
              height: 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Container(
        //   ///username
        //   margin: EdgeInsets.only(top: 30, right: 175, bottom: 2),
        //   child: Text(
        //     user!=null? (user.displayName!=null? user.displayName:"sss") : "sss";
        //     style: TextStyle(
        //       fontSize: 16.0,
        //       height: 1.3,
        //     ),
        //   ),
        // ),

        ///POINTS
        Row(children: [
          Container(
            ///POINTS
            margin: EdgeInsets.only(left: 40, top: 10, bottom: 2),
            child: Text(
              'Your Points: ',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.3,
              ),
            ),
          ),
          Container(
            ///POINTS
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 2),
            child: Text(
              '54',
              style: TextStyle(
                  fontSize: 16.0, height: 1.3, fontWeight: FontWeight.bold),
            ),
          ),
        ]),

        ///Search buttons---
        Row(children: [
          Container(
            margin: EdgeInsets.only(left: 30, top: 30),
            child: ElevatedButton(
              child: Text(
                'Scan a plant',
                style: TextStyle(fontSize: 15.0),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[300],
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0)),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top: 30),
            child: ElevatedButton(
              child: Text(
                'Search disease',
                style: TextStyle(fontSize: 15.0),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[300],
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0)),
              onPressed: () {
                //Navigator.push(context, SearchPage());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCustomForm()),
                );
              },
            ),
          ),
        ]),

        ///PREVIOUSLY SCANNED
        Container(
          ///username
          margin: EdgeInsets.only(top: 50, right: 105, bottom: 2),
          child: Text(
            'Previously Scanned',
            style: TextStyle(
              fontSize: 22.0,
              height: 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Container(
          // margin: EdgeInsets.only(left: 24),
          margin: EdgeInsets.only(top: 100),
          child: ElevatedButton(
            child: Text(
              'Add new plantation',
              style: TextStyle(fontSize: 15.0),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.green[300],
                padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0)),
            onPressed: () {},
          ),
        ),

        // Container(
        //   // margin: EdgeInsets.only(left: 24),
        //   margin: EdgeInsets.only(top: 20),
        //   child: ElevatedButton(
        //     child: Text(
        //       'Update password',
        //       style: TextStyle(fontSize: 15.0),
        //     ),
        //     style: ElevatedButton.styleFrom(
        //         primary: Colors.green[300],
        //         padding: EdgeInsets.symmetric(
        //             vertical: 15.0, horizontal: 100.0)),
        //     onPressed: () {
        //       Navigator.push(context, ResetPasswordPage());
        //     },
        //   ),
        // ),
      ])),
    );
  }
}

// class ProfilePage extends MaterialPageRoute<Null> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//   GoogleSignInAccount? user = _googleSignIn.currentUser;

//   ProfilePage()
//       : super(builder: (BuildContext context) {

//           return Scaffold(
//             floatingActionButton: FloatingActionButton(
//               onPressed: () async {

//               },
//             ),
//             body: SingleChildScrollView(
//                 child: Column(children: <Widget>[
//               Container(
//                 ///PROFILE PAGE HEADING
//                 margin:
//                     EdgeInsets.only(left: 0, top: 100, right: 95, bottom: 2),
//                 child: Text(
//                   'PROFILE PAGE',
//                   style: TextStyle(
//                       fontSize: 31.0, height: 1.3, fontWeight: FontWeight.bold),
//                 ),
//               ),

//               Container(
//                 ///username
//                 margin: EdgeInsets.only(top: 30, right: 175, bottom: 2),
//                 child: Text(
//                   'USERNAME HERE',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     height: 1.3,
//                   ),
//                 ),
//               ),

//               ///POINTS
//               Row(children: [
//                 Container(
//                   ///POINTS
//                   margin: EdgeInsets.only(left: 40, top: 10, bottom: 2),
//                   child: Text(
//                     'Your Points: ',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       height: 1.3,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   ///POINTS
//                   margin: EdgeInsets.only(left: 10, top: 10, bottom: 2),
//                   child: Text(
//                     '54',
//                     style: TextStyle(
//                         fontSize: 16.0,
//                         height: 1.3,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ]),

//               ///Search buttons---
//               Row(children: [
//                 Container(
//                   margin: EdgeInsets.only(left: 30, top: 30),
//                   child: ElevatedButton(
//                     child: Text(
//                       'Scan a plant',
//                       style: TextStyle(fontSize: 15.0),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.green[300],
//                         padding: EdgeInsets.symmetric(
//                             vertical: 15.0, horizontal: 30.0)),
//                     onPressed: () {},
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 24, top: 30),
//                   child: ElevatedButton(
//                     child: Text(
//                       'Search disease',
//                       style: TextStyle(fontSize: 15.0),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.green[300],
//                         padding: EdgeInsets.symmetric(
//                             vertical: 15.0, horizontal: 30.0)),
//                     onPressed: () {
//                       Navigator.push(context, SearchPage());
//                     },
//                   ),
//                 ),
//               ]),

//               ///PREVIOUSLY SCANNED
//               Container(
//                 ///username
//                 margin: EdgeInsets.only(top: 50, right: 105, bottom: 2),
//                 child: Text(
//                   'Previously Scanned',
//                   style: TextStyle(
//                     fontSize: 22.0,
//                     height: 1.3,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               Container(
//                 // margin: EdgeInsets.only(left: 24),
//                 margin: EdgeInsets.only(top: 100),
//                 child: ElevatedButton(
//                   child: Text(
//                     'Add new plantation',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.green[300],
//                       padding: EdgeInsets.symmetric(
//                           vertical: 15.0, horizontal: 100.0)),
//                   onPressed: () {},
//                 ),
//               ),

//               // Container(
//               //   // margin: EdgeInsets.only(left: 24),
//               //   margin: EdgeInsets.only(top: 20),
//               //   child: ElevatedButton(
//               //     child: Text(
//               //       'Update password',
//               //       style: TextStyle(fontSize: 15.0),
//               //     ),
//               //     style: ElevatedButton.styleFrom(
//               //         primary: Colors.green[300],
//               //         padding: EdgeInsets.symmetric(
//               //             vertical: 15.0, horizontal: 100.0)),
//               //     onPressed: () {
//               //       Navigator.push(context, ResetPasswordPage());
//               //     },
//               //   ),
//               // ),
//             ])),
//           );
//         });
//   // void openFile(PlatformFile file) {
//   //   OpenFile.open(file.path!);
//   // }
// }

void openFile(PlatformFile file) {
  OpenFile.open(file.path!);
}
