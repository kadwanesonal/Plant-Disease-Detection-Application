import 'package:flutter/material.dart';
import 'disease_description_page.dart';
import 'package:url_launcher/url_launcher.dart';

bool selectedDay = true;
var query = '';

void disp() {
  Text(
    'Bacterial spot of tomato is caused by Xanthomonas vesicatoria, Xanthomonas euvesicatoria, Xanthomonas gardneri, and Xanthomonas perforans. These bacterial pathogens can be introduced into a garden on contaminated seed and transplants, which may or may not show symptoms.',
    style: TextStyle(fontSize: 15.0),
  );
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  SearchPage createState() => SearchPage();
}

class SearchPage extends State<MyCustomForm> {
  final TextEditingController _myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myController.dispose();
    super.dispose();
  }

  _launchURL() async {
    disp();
    query = _myController.text;
    var url = 'https://www.google.com/search?q=' + '$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 124.3, left: 30, right: 30, bottom: 2),
                  child: Text('Search a disease',
                      style: TextStyle(
                          fontSize: 25.0,
                          height: 1.3,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(6),
                  child: TextField(
                    controller: _myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15.0),
                    ),
                    style: TextStyle(fontSize: 18.0),
                    //decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  child: ElevatedButton(
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[300],
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 125.0)),
                    onPressed: () {
                      _launchURL();

                      bool a = true;
                      Text(
                        a
                            ? 'Hello World'
                            : '', // When true, "Hello World" is shown, otherwhise nothing
                      );
                      //Text(
                      // 'Bacterial spot of tomato is caused by Xanthomonas vesicatoria, Xanthomonas euvesicatoria, Xanthomonas gardneri, and Xanthomonas perforans. These bacterial pathogens can be introduced into a garden on contaminated seed and transplants, which may or may not show symptoms.',
                      // style: TextStyle(fontSize: 15.0),
                      //);
                      Image.network(
                          'https://www.researchgate.net/profile/Amanda-Strayer-Scherer/publication/337978631/figure/fig1/AS:837096201785348@1576590695674/Bacterial-spot-of-tomato-disease-cycle-Credits-Ying-Yu-Liao-UF-IFAS.png');
                      //Navigator.push(context, DiseaseDescriptionPage());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
  SearchPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 124.3, left: 30, right: 30, bottom: 2),
                    child: Text('Search a disease',
                        style: TextStyle(
                            fontSize: 25.0,
                            height: 1.3,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                    /*child: TextFormField(
                      controller: _myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                      style: TextStyle(fontSize: 18.0),
                    ),*/
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: ElevatedButton(
                      child: Text(
                        'Search',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[300],
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 125.0)),
                      onPressed: () {
                        dac();
                       // _launchURL();

                        bool a=true;
                        Text(
                          a ? 'Hello World' : '', // When true, "Hello World" is shown, otherwhise nothing
                        );
                        //Text(
                         // 'Bacterial spot of tomato is caused by Xanthomonas vesicatoria, Xanthomonas euvesicatoria, Xanthomonas gardneri, and Xanthomonas perforans. These bacterial pathogens can be introduced into a garden on contaminated seed and transplants, which may or may not show symptoms.',
                         // style: TextStyle(fontSize: 15.0),
                        //);
                        Image.network('https://www.researchgate.net/profile/Amanda-Strayer-Scherer/publication/337978631/figure/fig1/AS:837096201785348@1576590695674/Bacterial-spot-of-tomato-disease-cycle-Credits-Ying-Yu-Liao-UF-IFAS.png');
                        //Navigator.push(context, DiseaseDescriptionPage());
                      },
                    ),
                  ),
                ],
              )
            ])),
          );
        });*/

}
