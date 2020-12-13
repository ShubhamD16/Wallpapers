import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_f/Components/base_Components.dart';
import 'package:wall_f/Components/set_Wallpaper.dart';

Widget load_image(String url,){

  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Image.asset(
      'asset/smoke_loading.gif',
      fit: BoxFit.cover,
    ),

    fit: BoxFit.cover,
    fadeInDuration: Duration(seconds: 1),
    fadeInCurve: Curves.bounceIn,
    errorWidget: (context, url, error) => Icon(Icons.warning_amber_rounded),
  );
}

class FinalPage extends StatefulWidget {
  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    String imageurl = args['imageUrl'];
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: load_cached_image(imageurl),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Set Wallpaper',
                style: GoogleFonts.caveat(fontSize: 20),
              ),
            ),
          ),

          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Card(
                   color: Colors.blueAccent.withOpacity(0.2),
                   child: RaisedButton(
                     color: Colors.transparent,
                     child: Text('Home',
                         style: GoogleFonts.caveat(fontSize: 30,color: Colors.white),),
                        onPressed: (){
                       SetWallpaper(context: context).setHomeScreenWallpaper(imageurl);
                        },
                   ),
                 ),
                  Card(
                    color: Colors.blueAccent.withOpacity(0.2),
                    child: RaisedButton(
                      color: Colors.transparent,
                      child: Text('Lock',
                        style: GoogleFonts.caveat(fontSize: 30,color: Colors.white),),
                        onPressed: (){
                        SetWallpaper(context: context).setLockScreenWallpaper(imageurl);
                        },
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent.withOpacity(0.2),
                    child: RaisedButton(
                      color: Colors.transparent,
                      child: Text('Both',
                        style: GoogleFonts.caveat(fontSize: 30,color: Colors.white),),
                      onPressed: (){
                        SetWallpaper(context: context).setBothScreenWallpaper(imageurl);
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
