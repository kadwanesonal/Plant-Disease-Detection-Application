import 'package:flutter/material.dart';

class DiseaseDescriptionPage extends MaterialPageRoute<Null> {
  DiseaseDescriptionPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Column(
                children: [
                  Container(
                    ///Disease Description Page Heading
                    margin:
                        EdgeInsets.only(top: 80, left: 20, right: 0, bottom: 2),
                    child: Text(
                      'DISEASE DESCRIPTION PAGE',
                      style: TextStyle(
                          fontSize: 23.0,
                          height: 1.3,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ])),
          );
        });
}