import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_f/Components/firebase_functions.dart';
import 'package:wall_f/Components/base_Components.dart';


class Staggredimageview extends StatefulWidget {
  @override
  _StaggredimageviewState createState() => _StaggredimageviewState();
}

class _StaggredimageviewState extends State<Staggredimageview> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final String category = args['category'];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(category,
          style: GoogleFonts.caveat(),
          ),
        ),
      ),
      body: Container(
        child: FirebaseStaggredGetDataByCategory(category: category,),
      ),
    );
  }
}

