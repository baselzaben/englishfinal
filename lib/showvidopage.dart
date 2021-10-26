import 'package:englishfinal/globalvar.dart';
import 'package:englishfinal/testPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'AdHelper.dart';
import 'partclasses.dart';
import 'videolist.dart';
import 'showvidopage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class showvideopage  extends StatefulWidget {
  String name="";String path="";String emailcompleted="";
  String rout="";
  String go="";
  String k="";



  showvideopage(String name,String path,String emailcompleted,String k,String go){
    this.path=path;
    this.name=name;
    this.rout=name;
    this.go=go;
    this.k=k;
    this.emailcompleted=emailcompleted;
    showvideopageState(name,path,emailcompleted, name, go,k);
  }



  @override
  showvideopageState createState() => showvideopageState(name,path,emailcompleted, rout, go,k);
}

class showvideopageState extends State<showvideopage> {
  String name="";String path="";String emailcompleted="";

  String rout="";String go="";String k="";

  showvideopageState(String name,String path,String emailcompleted,String rout,String go,String k){
    this.path=path;
    this.name=name; this.rout=name;
    this.go=go;
    this.rout=name;
    this.k=k;
    this.emailcompleted=emailcompleted;
  }



  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);






    // TODO: Add _isInterstitialAdReady

    // TODO: Implement _loadInterstitialAd()

      InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this._interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                //  _moveToHome();
              },
            );

            _isInterstitialAdReady = true;
          },
          onAdFailedToLoad: (err) {
            print('Failed to load an interstitial ad: ${err.message}');
            _isInterstitialAdReady = false;
          },
        ),
      );








    super.initState();
  }

  loadad(){
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //  _moveToHome();
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _interstitialAd?.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: hexToColor(globalvar.enishialcolor2),
        title: Text(name),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return  Container(
              color: hexToColor(globalvar.enishialcolor),
height: double.infinity,
              child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 50,bottom: 10),
                  child: Text('"لن تتمكن من مشاهدة الحصة التالية الا بعد أكمال الاختبار"',style: TextStyle(color:  Colors.black,fontSize: 15),)

              ),


              Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20,bottom: 10),
                  child: AspectRatio(
    aspectRatio: _controller.value.aspectRatio,
    child: VideoPlayer(_controller),
    )),


              Container(
                color: Colors.black12,
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20,bottom: 10),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0,bottom: 0),
                  child:TextButton(onPressed: (){
                    loadad();
                    selectItem(rout,go,k,context);
          /*Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegesterScreen()),);*/

          }, child: Text('الذهاب الى الاختبار',style: TextStyle(color:  hexToColor(globalvar.enishialcolor2),fontSize: 15),)))


    ]),
            );

              Center(

            );




          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexToColor(globalvar.enishialcolor2),
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child:
        Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),

    );
  }
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  selectItem(String rout,String go,String key,BuildContext context) {
    if (_isInterstitialAdReady) {
      _interstitialAd?.show();
    } else {

print('nooooo,error');
    }
   // _interstitialAd?.show();
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('compleeete')));
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => testPage(rout,go,k,emailcompleted)),);

  }

}