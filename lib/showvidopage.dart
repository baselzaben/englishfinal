import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'partclasses.dart';
import 'videolist.dart';
import 'showvidopage.dart';

class showvideopage  extends StatefulWidget {
  String name="";String path="";String emailcompleted="";
  showvideopage(String name,String path,String emailcompleted){
    this.path=path;
    this.name=name;
    this.emailcompleted=emailcompleted;
    showvideopageState(name,path,emailcompleted);
  }



  @override
  showvideopageState createState() => showvideopageState(name,path,emailcompleted);
}

class showvideopageState extends State<showvideopage> {
  String name="";String path="";String emailcompleted="";



  showvideopageState(String name,String path,String emailcompleted){
    this.path=path;
    this.name=name;
    this.emailcompleted=emailcompleted;
  }



  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Demo"),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 50,bottom: 10),
                child: AspectRatio(
    aspectRatio: _controller.value.aspectRatio,
    child: VideoPlayer(_controller),
    )),


            Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20,bottom: 10),
                child:TextButton(onPressed: (){

          /*Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegesterScreen()),);*/

          }, child: Text('الذهاب الى الاختبار')))


    ]);

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
}