import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class RegesterScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namedController = TextEditingController();

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
     /* appBar: new AppBar(
        title: new Text("Multi Page Application Page-1"),
      ),*/
      body:SingleChildScrollView(
              child: Column(
                  children: <Widget>[

                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20),

                      child: Image.asset('assets/images/logo.jpg'),
                    ),

                    Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 50),


                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 20),
                                child: TextField(
                                  controller: namedController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                    hintText: 'Input name',
                                    prefixIcon: Icon(Icons.favorite),
                                  ),
                                ),),
                              Container(
                                margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 25),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                    hintText: 'Input your Email',
                                    prefixIcon: Icon(Icons.favorite),
                                  ),
                                ),),
                              Container(
                                margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 25),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: 'Input your pasword',
                                    prefixIcon: Icon(Icons.favorite),
                                  ),
                                ),),

                              Container(
                                  width: 200
                                  ,
                                  height: 40,
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 70,bottom: 50),
                                  child: RaisedButton(
                                    color: Colors.green, // background
                                    textColor: Colors.white, // foreground
                                    onPressed: () {

if(!namedController.text.isEmpty &&namedController.text.isNotEmpty&&!namedController.text.isEmpty )
{
  String email="";
  DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('users');




  String em=emailController.text.toString();
  em=em.replaceAll('@','');
  em=em.replaceAll('.', '');

  DatabaseReference _messagesRef2 =
  FirebaseDatabase.instance.reference();
 // _messagesRef2.orderByChild('email').equalTo(emailController.text.toString()).once().then((snapshot){email=snapshot.value;});
  String fullemail="";

  _messagesRef2.once().then((DataSnapshot snapshot) {
   print('Data : ${snapshot.value.toString()}');
    fullemail='Data : ${snapshot.value[0]..toString()}';
  }).whenComplete(() =>


  {
    if(fullemail.contains(emailController.text)){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('موجود')))
    } else
      {

        _messagesRef.child(getRandString(8)).set({
          'name': namedController.text.toString(),
          'email': emailController.text.toString(),
          'password': passwordController.text+formatsrting(emailController.text)
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Successfully Added')));
          namedController.clear();
          emailController.clear();
          passwordController.clear();
        }).catchError((onError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(onError)));
        })}
  });
}else{
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('complet information')));
}
                                    },
                                    child: Text('Register'),
                                  )
                              ),

                              Container(
                                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10),
                                  child: TextButton(onPressed: (){

                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => HomeScreen()),);

                                  }, child: Text(' already have account ?')))

                            ],
                          ),
                        )


                    ),




                  ]))
    );
  }
  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }

  String formatsrting(String len) {
   String len2=len.replaceAll('@', '');
   len2=len2.replaceAll('.', '');
    return len2;
  }

}