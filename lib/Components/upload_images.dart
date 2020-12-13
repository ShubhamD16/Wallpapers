import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

class UploadImge extends StatefulWidget {
  @override
  _UploadImgeState createState() => new _UploadImgeState();
}

class _UploadImgeState extends State<UploadImge> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  String selectedCategory = 'null';

  @override
  void initState() {

    setState(() {
    });
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return GestureDetector(
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
          onDoubleTap: (){
            images.removeAt(index);
          },
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Upload(){

  }

  Dropdownwidgett(List categorylist){
    String dropdownValue = categorylist[0];
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.red, fontSize: 18),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (data) {
        setState(() {
          dropdownValue = data;
          selectedCategory = dropdownValue;
        });
      },
      items: categorylist.map<DropdownMenuItem>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Upload Images With Category'),
        ),
        body: Column(
          children: <Widget>[

            Center(child: Text('Error: $_error')),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('categories').doc('categories').snapshots(),
              builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData){
                  List categorylist = snapshot.data.get('categories');
                  return Dropdownwidgett(categorylist);
                }
                else{
                  return Container(
                    child: Text('loading'),
                  );
                }

              },
            ),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            ),
            RaisedButton(
              child: Text('upload images'),
              onPressed: Upload(),
            ),
            Text(selectedCategory)
          ],
        ),
      ),
    );
  }
}