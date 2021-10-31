import 'package:englishfinal/RegesterScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'AboutUs.dart';
import 'AdHelper.dart';
import 'partclasses.dart';
import 'globalvar.dart';

// TODO: Import ad_helper.dart

// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'main.dart';
class MainPage extends StatefulWidget{
  HomePage createState()=> HomePage();
}
class HomePage extends State<MainPage> {
  final String _content = 'https://play.google.com/store/apps/details?id=com.baselalzaben.englishfinal&hl=ar&gl=US';

  void _shareContent() {
    Share.share(_content);
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late BannerAd _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // TODO: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // TODO: Load an ad
    _ad.load();
  }










  DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('items');




  String email=globalvar.email;


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: hexToColor(globalvar.enishialcolor2),
        title: Text("الصفحة الرئيسية")),
        body: FutureBuilder(
        future: _messagesRef.once(),
    // future: FirebaseDatabase.instance
    //     .reference()
    //     .child("ScannedResults")
    //     .once(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting)
    return new Text('جار التحميل....');
    if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
    List scannedItemsValues = [];
    snapshot.data.value.forEach(
    (_, values) => scannedItemsValues.add(values["name"])
    );
    List scannedItemsValues2 = [];
    snapshot.data.value.forEach(
            (_, values) => scannedItemsValues2.add(values["title"])
    );
    print(scannedItemsValues);
    return Container(
      height: double.infinity,
      color: hexToColor(globalvar.enishialcolor),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Card(
          child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

       ListView.builder(
           shrinkWrap: true,
      itemCount: scannedItemsValues.length,
      itemBuilder: (BuildContext context, int index) {


      print(scannedItemsValues[index]);
      return  GestureDetector(
            onTap: () => selectItem(scannedItemsValues[index],scannedItemsValues2[index],context),
            /*onTap: () => (){

            Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegesterScreen()),);
            print("basell");
       *//*     ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('complet information')));*//*
            },*/
          child: Container(

              margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),
              padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),

   /*child: Card(


      child: Column(
      mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Container(

            margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),
      child: Text(scannedItemsValues[index]),

      )]))*/

            child: Card(


              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
              elevation: 5,
              margin: EdgeInsets.all(5),
                      child: Container(

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF141F55),
                                  const Color(0xFF0C1D3D),
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),




                     child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10.0, right: 0.0,top: 10,bottom: 10),

                              margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),
                              child: Text(scannedItemsValues2[index],style: TextStyle(color: Colors.white,fontSize: 20),),

                            ),


                          ])

            ),



                    )




            ),

          );

      },


      ),


                Container(
                  child: AdWidget(ad: _ad),
                  width: _ad.size.width.toDouble(),
                  height: 80.0,
                  alignment: Alignment.center,
                )


      ]))
    ),
        ));
    },
    ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [

            Container(

                color: hexToColor(globalvar.enishialcolor),
              width: 300,
              height: 200,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(

                        child: Container(

                          margin: const EdgeInsets.only(left: 5.0, right: 10.0,top: 30,bottom: 0),

                          child: Image.asset('assets/images/logo.png',height: 120,),
                        ),

                      ),
                      Container(

                          child: Text(email,style: TextStyle(color: Colors.white),)

                      )])



            ),



            ListTile(

              title:  Text('مشاركة التطبيق'), leading: Icon(Icons.share,),

              onTap: () {
                _shareContent();
                // Update the state of the app
                // ...
                // Then close the drawer
              //  Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('من نحن'), leading: Icon(Icons.account_box_outlined,),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
               // Navigator.pop(context);

                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUs()),);

              },
            ),

            ListTile(
              title: const Text('تسجيل الخروج'), leading: Icon(Icons.logout,),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pop(context);

                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreenPage()),);

              },
            ),



          ],
        ),
      ),
    );
  }

  selectItem(String product,String title,BuildContext context) {
globalvar.homeselecteditem=product;
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => partclassesPage(product,title)),);
  }
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}