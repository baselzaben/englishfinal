import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'partclasses.dart';
import 'videolist.dart';

import 'main.dart';

class partclasses extends StatelessWidget {
  var go='';
  var title2="";
DatabaseReference _messagesRef =FirebaseDatabase.instance.reference().child('items').child('en').child('items') ;

partclasses(var gg,var title){
   go=gg;
   title2=title;
    _messagesRef= FirebaseDatabase.instance.reference().child('items').child(go).child('items');
  }



  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title2),backgroundColor: hexToColor(globalvar.enishialcolor2),),
      body: FutureBuilder(
        future: _messagesRef.once(),
        // future: FirebaseDatabase.instance
        //     .reference()
        //     .child("ScannedResults")
        //     .once(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return new Text('جار التحميل...');
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          List scannedItemsValues = [];
          snapshot.data.value.forEach(
                  (_, values) => scannedItemsValues.add(values["name"])
          );
          List scannedItemstitle = [];
          snapshot.data.value.forEach(
                  (_, values) => scannedItemstitle.add(values["title"])
          );

          print(scannedItemsValues);
          return ListView.builder(
            itemCount: scannedItemsValues.length,
            itemBuilder: (BuildContext context, int index) {


              print(scannedItemsValues[index]);
              return  GestureDetector(
                  onTap: () => selectItem(scannedItemsValues[index],go,scannedItemstitle[index],context),
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
              child: Text(scannedItemstitle[index],style: TextStyle(color: Colors.white,fontSize: 20),),

              )])

              ),



              )

              ));
            },
          );
        },
      ),

/*      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
    );
  }

selectItem(String name,String rout,String title,BuildContext context) {

  Navigator.push(context,
    MaterialPageRoute(builder: (context) => videolist(name,rout,title)));
}
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}