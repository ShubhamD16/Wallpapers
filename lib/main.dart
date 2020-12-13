import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:wall_f/Components/CategoryView.dart';
import 'package:wall_f/Components/Finalpage.dart';
import 'package:wall_f/Components/firebase_functions.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:wall_f/Components/upload_images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FacebookAudienceNetwork.init(
    testingId: "8a81c915-3cfd-41d8-a97c-53acdb6ba0c0",
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/staggred': (context) => Staggredimageview(),
          '/finalpage': (context) => FinalPage(),
        });
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'cartoon',
      'nature',
      'cartoon',
      'cartoon',
      'nature',
      'cartoon',
      'cartoon',
      'nature',
      'cartoon'
    ];
    int i = 0;
    int loaded = 0;
    List<Widget> catlist = [];
    for(i=0; i<categories.length;i++) {
      if (i % 2 == 0 && i > 0) {
        Widget ad = FacebookNativeAd(
          placementId: "811863856044159_811882499375628",
          adType: NativeAdType.NATIVE_AD,
          keepAlive: true,
          width: double.infinity,
          height: 300,
          backgroundColor: Colors.blue,
          titleColor: Colors.white,
          descriptionColor: Colors.white,
          buttonColor: Colors.deepPurple,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.white,
          listener: (result, value) {
            print("Native Ad: $result --> $value");
            print('loaded $loaded');
            loaded += 1;
          },
          keepExpandedWhileLoading: true,
          expandAnimationDuraion: 500,
        );
          catlist.add(ad);
      }
      else{
        catlist.add(FirebaseSliderGetDataByCategory(category: categories[i],));
      }
    }


    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
                child: Image.asset('asset/block_black_background.jpg',fit: BoxFit.fill,)
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.white30.withOpacity(0.3),
              centerTitle: true,
              title: Text('Papers'),
            ),
            body: Container(
              color: Colors.transparent,
              child: ListView(
                children: catlist,
              )
              ),
          )
        ],
      ),
    );
  }
}

