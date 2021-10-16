import 'package:englishfinal/RegesterScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'partclasses.dart';
import 'globalvar.dart';

import 'main.dart';

class HomePage extends StatelessWidget {
  DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('items');
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title")),
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
    List scannedItemsValues2 = [];
    snapshot.data.value.forEach(
            (_, values) => scannedItemsValues2.add(values["title"])
    );
    print(scannedItemsValues);
    return ListView.builder(
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

   child: Card(
 

    child: Column(
    mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),
    child: Text(scannedItemsValues[index]),

    )])))

    );
    },
    );
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
      ),
    );
  }

  selectItem(String product,String title,BuildContext context) {

    Navigator.push(context,
      MaterialPageRoute(builder: (context) => partclasses(product,title)),);
  }
}