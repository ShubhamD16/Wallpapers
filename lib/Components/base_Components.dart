import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_f/Components/set_Wallpaper.dart';

Widget load_cached_image(String url,){

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


Widget CategoryImages(BuildContext context,String category, List imageUrl){

  double height = 300;
  double width = 200;
  return Container(
    height: 400,
    margin: EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: Colors.transparent,
      //border: Border.all(color: Color.fromRGBO(0, 255, 0, 1),width: 3,style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(10)
    ),
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),
            color: Colors.white.withOpacity(0.3),
          ),
          child: Center(
            child: Text(category,
            style: GoogleFonts.pacifico(fontSize: 22,letterSpacing: 2.5,color: Colors.white),
            ),
          ),
        ),
        Divider(height: 4,thickness:1),
        Container(
          height:height,
          child: Swiper(
            itemBuilder: (BuildContext context,int index){
              if(imageUrl[index] == 'ad'){
                Widget ad = FacebookNativeAd(
                  placementId: "811863856044159_811888886041656",
                  adType: NativeAdType.NATIVE_BANNER_AD,
                  width: 200,
                  height: 100,
                  keepAlive: true,
                  isMediaCover: true,
                  backgroundColor: Colors.lightBlue,
                  titleColor: Colors.white,
                  descriptionColor: Colors.white,
                  buttonColor: Colors.deepPurple,
                  buttonTitleColor: Colors.white,
                  buttonBorderColor: Colors.white,
                  listener: (result, value) {
                    print("Native Ad: $result --> $value");
                  },
                  keepExpandedWhileLoading: false,
                  expandAnimationDuraion: 500,
                );
                return Column(
                  children: [
                    ad,
                    ad,
                    ad,
                  ],
                );
              }
              else{
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Stack(
                        children: [
                          Positioned.fill(
                            bottom: 0.0,
                            child: load_cached_image(imageUrl[index]),
                          ),
                          Positioned.fill(
                            child: new Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (() {
                                  print(index);
                                  Navigator.pushNamed(context, '/finalpage',arguments:{'imageUrl':imageUrl[index]});
                                }),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                );
              }
            },
            itemCount: imageUrl.length,
            viewportFraction: 0.5,
            scale: 0.6,
          ),
        ),
        Divider(height: 3,color: Colors.transparent,),
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(5),bottomRight: Radius.circular(5)),
            color: Colors.deepPurple.withOpacity(0.3),
          ),
          child: FlatButton(
              onPressed: ((){
                Navigator.pushNamed(context, '/staggred',arguments: {'category':category});
              }),
              child:Text('View All',
              style: GoogleFonts.atomicAge(
                letterSpacing: 1,
                wordSpacing: 2,
                color: Colors.white
              ),
              )
          ),
        ),
      ],
    ),
  );
}


Widget AllImagesStaggred(BuildContext context,String category,List imageurl){
  return Container(
    margin: EdgeInsets.all(12),
    child: AnimationLimiter(
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          itemCount: imageurl.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if(imageurl[index] == 'ad'){
              return FacebookNativeAd(
                placementId: "811863856044159_811882499375628",
                adType: NativeAdType.NATIVE_AD,
                width: 200,
                height: 300,
                keepAlive: true,
                backgroundColor: Colors.blue,
                titleColor: Colors.white,
                descriptionColor: Colors.white,
                buttonColor: Colors.deepPurple,
                buttonTitleColor: Colors.white,
                buttonBorderColor: Colors.white,
                listener: (result, value) {
                  print("Native Ad: $result --> $value");
                },
                keepExpandedWhileLoading: false,
                expandAnimationDuraion: 500,
              );
            }
            else{
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                          children: [
                            Positioned.fill(
                              bottom: 0.0,
                              child: load_cached_image(imageurl[index]),
                            ),
                            Positioned.fill(
                              child: new Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (() {
                                    print(index);
                                    Navigator.pushNamed(context, '/finalpage',arguments:{'imageUrl':imageurl[index]});
                                  }),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ),
              );
            }
          },
          staggeredTileBuilder: (index) {
            return new StaggeredTile.count(1, index == 1 ? 1.2 : 1.8);
          }),
    ),
  );
}




