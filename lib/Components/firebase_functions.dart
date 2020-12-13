import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_f/Components/CategoryView.dart';
import 'package:wall_f/Components/base_Components.dart';
import 'package:http/http.dart' as http;

Future<List> GetImagelistByCatagory(String category) async {
  List datalist = [];
  await FirebaseFirestore.instance.collection('Wallpapers')
      .where('category', isEqualTo: category).get()
      .then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
          datalist.add(doc.get('url'));
          })
    });
  return datalist;
}

class FirebaseSliderGetDataByCategory extends StatefulWidget {
  final String category;
  FirebaseSliderGetDataByCategory({@required this.category});
  @override
  _FirebaseSliderGetDataByCategoryState createState() => _FirebaseSliderGetDataByCategoryState();
}

class _FirebaseSliderGetDataByCategoryState extends State<FirebaseSliderGetDataByCategory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Wallpapers')
        .where('category', isEqualTo: widget.category).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        else{
          List datalist = [];
          int i=0;
          snapshot.data.docs.forEach((doc) {
              if(i > 0 && i%5 == 0){
                datalist.add('ad');
              }
              i += 1;
              datalist.add(doc.get('url'));
            });

          return CategoryImages(context, widget.category, datalist);
        }
      },
    );
  }
}


class FirebaseStaggredGetDataByCategory extends StatefulWidget {
  final String category;
  FirebaseStaggredGetDataByCategory({@required this.category});
  @override
  _FirebaseStaggredGetDataByCategoryState createState() => _FirebaseStaggredGetDataByCategoryState();
}

class _FirebaseStaggredGetDataByCategoryState extends State<FirebaseStaggredGetDataByCategory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Wallpapers')
          .where('category', isEqualTo: widget.category).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              child: Image.asset('asset/smoke_loading.gif'),
            ),
          );
        }

        else{
          List datalist = [];
          int i = 0;
          snapshot.data.docs.forEach((doc) {
            if(i % 6 == 0 && i>0){
              datalist.add('ad');
            }
            datalist.add(doc.get('url'));
            i += 1;
          });
          datalist.add('ad');
          return AllImagesStaggred(context, widget.category, datalist);
        }
      },
    );
  }
}



class PixabayImages extends StatefulWidget {
  String query;
  PixabayImages(this.query);
  @override
  _PixabayImagesState createState() => _PixabayImagesState();
}

class _PixabayImagesState extends State<PixabayImages> {
  String key = '19481433-35b905b4fad096bcde1c173d5';
  String query = 'nature';
  http.Response response;

  Future Getimagedata(String key,String query) async{
    String url = 'https://pixabay.com/api/?key='+key+'&='+query+'&image_type=photo';
    print(url);
    try {
      this.response = await http.get(url);
    }
    catch(e){
      print('eeeerrrroooorrrr'+e);
    }

    if(this.response.statusCode == 200){
      var alldata = jsonDecode(this.response.body);
      var hit = alldata['hits'];
      //Map dat = jsonDecode(hit[10]);
      //print(dat['largeImageURL']);
      print(hit);
    }
    else{
      print('error with http link');
    }
  }



  @override
  void initState() {
    Getimagedata(this.key, this.query);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('response'),
    );
  }
}

