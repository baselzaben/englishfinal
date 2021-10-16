import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'partclasses.dart';
import 'videolist.dart';
import 'showvidopage.dart';

class videolist extends StatelessWidget {
  var go='';
  var rout='';
  var title='';
  DatabaseReference _messagesRef =FirebaseDatabase.instance.reference().child('items').child('en').child('items') ;

  videolist(var gg,var rout,String title){
    go=gg;
    this.rout=rout;
    this.title=title;
    _messagesRef= FirebaseDatabase.instance.reference().child('items').child(rout).child('items').child(go).child('videos');
  }



  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder(
        future: _messagesRef.once(),
        // future: FirebaseDatabase.instance
        //     .reference()
        //     .child("ScannedResults")
        //     .once(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return new Text('Loading....');
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          List scannedItemsValues = [];
          snapshot.data.value.forEach(
                  (_, values) => scannedItemsValues.add(values["name"])
          );
          List scannedItemspath = [];
          snapshot.data.value.forEach(
                  (_, values) => scannedItemspath.add(values["path"])
          );
          List scannedItemsmailcomplted = [];
          snapshot.data.value.forEach((_, values) => scannedItemsmailcomplted.add(values["emailscompleted"])
          );
          print(scannedItemsValues);
          return GridView.builder(
            itemCount: scannedItemsValues.length,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {


              print(scannedItemsValues[index]);
              return  GestureDetector(

                  onTap: () => selectItem(scannedItemsValues[index],scannedItemspath[index],scannedItemsmailcomplted[index],globalvar.email,context),
                  /*onTap: () => (){

        Navigator.push(context,
      MaterialPageRoute(builder: (context) => RegesterScreen()),);
        print("basell");
     *//*     ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('complet information')));*//*
        },*/
                  child: Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),

                      child: Card(
color: Colors.lightBlue,

                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                    child: checkcomplet(scannedItemsValues[index],scannedItemspath[index],scannedItemsmailcomplted[index],globalvar.email,context)),

                                Container(
                          alignment:Alignment.center,
                                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20,bottom: 10),
                                  child: Text(scannedItemsValues[index],  style: TextStyle(color: Colors.white),),

                                )])))

              );
            },
          );
        },
      ),

    );
  }

  selectItem(String name,String path,String emailcompleted,String email,BuildContext context) {
    print(emailcompleted);
    print(formatsrting(email));
    if (formatsrting(email).contains(formatsrting((emailcompleted)))) {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('compleeete')));
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => showvideopage(name,path,emailcompleted)),);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('noooot compleeeted')));
    }

  }

  Widget  checkcomplet(String name,String path,String emailcompleted,String email,BuildContext context) {
    if (formatsrting(email).contains(formatsrting((emailcompleted)))) {
      return  Container(
        alignment:Alignment.center,
        margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20,bottom: 10),
        child: Image.asset('assets/images/complet.png'),height: 50,width: 50,);

    }
    return  Container(
      alignment:Alignment.center,
      margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20,bottom: 10),
    child: Image.asset('assets/images/qustion.png'),height: 50,width: 50,);

  }
  String formatsrting(String len) {
    String len2=len.replaceAll('@', '');
    len2=len2.replaceAll('.', '');
    return len2;
  }
}
