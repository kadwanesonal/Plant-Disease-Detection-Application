//command to run the code
// flutter run --no-sound-null-safety

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:plant_disease_frontend/screens/profile_page.dart';
import 'search_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_disease_frontend/utilities/constants.dart' as constants;
import 'package:url_launcher/url_launcher.dart';

//for camera code
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

bool _loading = true;
late File _image;
late List _output;
final picker = ImagePicker();

var diseases = [
  "Pepper bell Bacterial spot",
  "Pepper bell healthy",
  "Potato Early blight",
  "Potato healthy",
  "Potato Late blight",
  "Tomato Target Spot",
  "Tomato YellowLeaf Curl Virus",
  "Tomato Bacterial spot",
  "Tomato Early blight",
  "Tomato Late blight",
  "Tomato Leaf Mold",
  "Tomato Septoria leaf spot",
  "Tomato Spider mites Two spotted spider mite"
];

var description = [
  "Bacterial leaf spot, caused by Xanthomonas campestris pv. vesicatoria, is the most common and destructive disease for peppers in the eastern United States. It is a  gram-negative, rod-shaped bacterium that can survive in seeds and plant debris from one season to another.",
  "They are an excellent source of vitamin C, especially the ripest peppers, which are red. Peppers are also a good source of vitamin A and fiber. Bell peppers also have antioxidant properties, which may help to protect against diseases such as cardiovascular disease and some cancers.",
  "Early blight of potato is caused by the fungal pathogen Alternaria solani. The disease affects leaves, stems and tubers and can reduce yield, tuber size, storability of tubers, quality of fresh-market and processing tubers and marketability of the crop.",
  "Potatoes are rich in vitamins, minerals and antioxidants, which make them very healthy. Studies have linked potatoes and their nutrients to a variety of impressive health benefits, including improved blood sugar control, reduced heart disease risk and higher immunity.",
  "A disease of solanaceous plants (such as the potato and tomato) that is caused by a fungus (Phytophthora infestans) and is characterized by decay of stems, leaves, and in the potato also of tubers.",
  "Target spot of tomato is a fungal disease that attacks a diverse assortment of plants, including papaya, peppers, snap beans, potatoes, cantaloupe, and squash as well as passion flower and certain ornamentals.",
  "This type of leaf curl is thought to be a reaction to environmental stress. Causes for the stress vary from excessive moisture and/or nitrogen, high temperatures, insufficient water, severe pruning, or root damage of some type.",
  "Bacterial spot of tomato is caused by Xanthomonas vesicatoria, Xanthomonas euvesicatoria, Xanthomonas gardneri, and Xanthomonas perforans. These bacterial pathogens can be introduced into a garden on contaminated seed and transplants, which may or may not show symptoms.",
  "Any of several blights of plants in which symptoms appear early in the season: such as. a : a leaf spot especially of the potato and tomato that is caused by a fungus.",
  "Late blight is a potentially devastating disease of tomato and potato, infecting leaves, stems and fruits of tomato plants. The disease spreads quickly in fields and can result in total crop failure if untreated. Late blight of potato was responsible for the Irish potato famine of the late 1840s.",
  "Tomato leaf mold is a fungal disease that can develop when there are extended periods of leaf wetness and the relative humidity is high (greater than 85 percent). The optimal temperature tomato leaf mold is in the low 70s. Symptoms of disease include yellow spots on the upper leaf surface.",
  "Septoria leaf spot on tomato (Lycopersicon) Septoria leaf spot is caused by a fungus, Septoria lycopersici. It is one of the most destructive diseases of tomato foliage and is particularly severe in areas where wet, humid weather persists for extended periods.",
  "Spider mites are members of the Acari (mite) family Tetranychidae, which includes about 1,200 species. They generally live on the undersides of leaves of plants, where they may spin protective silk webs, and they can cause damage by puncturing the plant cells to feed. Spider mites are known to feed on several hundred species of plants.",
];

var remedies = [
  "https://extension.wvu.edu/lawn-gardening-pests/plant-disease/fruit-vegetable-diseases/bacterial-leaf-spot-of-pepper#:~:text=Seed%20treatment%20with%20hot%20water,relatively%20low%20with%20bleach%20treatment.",
  "https://www.gardentech.com/blog/garden-and-lawn-protection/growing-your-own-bell-peppers#:~:text=Keep%20bell%20peppers%20well-watered,keep%20peppers%20firm%20and%20healthy.",
  "https://www.gardeningknowhow.com/edible/vegetables/potato/potato-early-blight-treatment.htm",
  "https://harvesttotable.com/how_to_grow_potatoes/",
  "https://www.intechopen.com/chapters/58251",
  "https://www.gardeningknowhow.com/edible/vegetables/tomato/target-spot-on-tomatoes.htm#:~:text=The%20following%20tips%20for%20treating,thus%20beginning%20the%20disease%20anew.",
  "https://www.farmprogress.com/controlling-tomato-yellow-leaf-curl-virus",
  "https://hort.extension.wisc.edu/articles/bacterial-spot-of-tomato/#:~:text=A%20plant%20with%20bacterial%20spot,DO%20NOT%20eat%20symptomatic%20fruit.",
  "https://www.pesches.com/blogs/news/how-to-fight-early-blight#:~:text=Treatment,of%20these%20treatments%20are%20organic.",
  "https://www.gardeningknowhow.com/edible/vegetables/tomato/tomato-late-blight.htm#:~:text=For%20the%20home%20gardener%2C%20fungicides,can%20strike%20at%20any%20time.",
  "https://www.gardeningknowhow.com/edible/vegetables/tomato/managing-tomato-leaf-mold.htm",
  "https://www.thespruce.com/identifying-and-controlling-septoria-leaf-spot-of-tomato-1402974",
  "https://www.gardeningknowhow.com/plant-problems/pests/insects/two-spotted-spider-mite-control.htm#:~:text=The%20best%20way%20to%20begin,every%207%20days%20or%20so.",
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //camera code===============

  @override
  void initState() {
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //dis function disposes and clears our memory
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    //this function runs the model on the image
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 36, //the amout of categories our neural network can predict
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  pickImage() async {
    //this function to grab the image from camera
    var image = await picker.getImage(source: ImageSource.camera);
    // ignore: unnecessary_null_comparison
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  //camera code end=============

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    void callbackLogOut() async {
      user = await _googleSignIn.signOut();
      setState(() {});
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 124.3, left: 30, right: 30, bottom: 20),
                child: const Text(constants.homePageHeading,
                    style: TextStyle(
                        fontSize: 31.0,
                        height: 1.3,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 30, right: 30, bottom: 30),
                child: Text(
                    'Just scan or type out the disease your\nplant has and get remedies you can\nmake at home.',
                    style: TextStyle(
                        fontSize: 18.0,
                        height: 1.3,
                        color: Colors.black.withOpacity(0.5)),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          Row(children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: ElevatedButton(
                child: const Text(
                  'Scan a plant',
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[300],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0)),
                onPressed: () {
                  pickImage();
                  Navigator.push(context, LoadingPage());
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: ElevatedButton(
                child: const Text(
                  'Search disease',
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[300],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0)),
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
          Column(children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: user == null
                  ? TextButton(
                      child: const Text(
                        'Sign In Using Google',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      style: TextButton.styleFrom(primary: Colors.green[900]),
                      onPressed: () async {
                        user = await _googleSignIn.signIn();
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    user?.displayName,
                                    user?.photoUrl,
                                    user?.email,
                                    callbackLogOut)));
                      },
                    )
                  : TextButton(
                      child: const Text(
                        'Go To your Profile',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      style: TextButton.styleFrom(primary: Colors.green[900]),
                      onPressed: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    user?.displayName,
                                    user?.photoUrl,
                                    user?.email,
                                    callbackLogOut)));
                      },
                    ),
            ),
          ]),
          Column(children: const [
            Image(
              image: AssetImage('assets/hero_image.png'),
            ),
          ]),
        ]),
      ),
    );
  }
}

//Loading Page========================

class LoadingPage extends MaterialPageRoute<Void> {
  LoadingPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 124.3, left: 30, right: 30, bottom: 2),
                    child: const Text('Your result is ready!',
                        style: TextStyle(
                            fontSize: 25.0,
                            height: 1.3,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      child: const Text(
                        'Show me',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[300],
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 125.0)),
                      onPressed: () {
                        //_launchURL();
                        Navigator.push(context, DiseaseDescriptionPage());
                      },
                    ),
                  ),
                ],
              )
            ])),
          );
        });
}

List diseaseName = [
  for (int i = 0; i < 13; i++)
    if (_output[0]['label'] == diseases[i]) diseases[i]
];

List diseaseDesc = [
  for (int i = 0; i < 13; i++)
    if (_output[0]['label'] == diseases[i]) description[i]
];

_launchURL() async {
  List diseaseRemedy = [
    for (int i = 0; i < 13; i++)
      if (_output[0]['label'] == diseases[i]) remedies[i]
  ];
  /*RaisedButton(
    onPressed: _launchURL,
    child: new Text('Show Flutter homepage'),
  );*/
  /*_launchURL() async {
    var url = Uri.encodeComponent(diseaseRemedy[0]);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/
  //var url = Uri.encodeComponent(diseaseRemedy[0]);

  const url =
      'https://hort.extension.wisc.edu/articles/bacterial-spot-of-tomato/#:~:text=A%20plant%20with%20bacterial%20spot,DO%20NOT%20eat%20symptomatic%20fruit.';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//Disease Description Page=======================
class DiseaseDescriptionPage extends MaterialPageRoute<void> {
  DiseaseDescriptionPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Column(
                children: [
                  Container(
                    ///Disease Description Page Heading
                    margin: const EdgeInsets.only(
                        top: 80, left: 20, right: 0, bottom: 2),
                    // child: const Text(
                    //   'DISEASE DESCRIPTION PAGE',
                    //   style: TextStyle(
                    //       fontSize: 23.0,
                    //       height: 1.3,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ),
                  Center(
                    child: _loading == true
                        ? null //show nothing if no picture selected
                        : Column(
                            children: [
                              SizedBox(
                                height: 250,
                                width: 250,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 25,
                                thickness: 1,
                              ),

                              //Result code===================
                              Text(
                                diseaseName[0],
                                style: TextStyle(
                                    fontSize: 23.0,
                                    height: 1.3,
                                    fontWeight: FontWeight.bold),
                              ),

                              Text(diseaseDesc[0]),

                              //Remedy button===================
                              Container(
                                margin: const EdgeInsets.all(30),
                                child: new Column(
                                  children: <Widget>[
                                    ElevatedButton(
                                      child: const Text(
                                        'Show Remedies',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green[300],
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 125.0)),
                                      onPressed: () {
                                        _launchURL();
                                        //Navigator.push(
                                        // context, DiseaseDescriptionPage());
                                      },
                                    ),
                                    /*new ElevatedButton(
                                        onPressed: _launchURL,
                                        child: new Text("More Info")),*/
                                  ],
                                ),
                              ),

                              // Text(diseaseRemedy[0]),
                              const Divider(
                                height: 25,
                                thickness: 1,
                              ),
                            ],
                          ),
                  ),
                ],
              )
            ])),
          );
        });
}
