import 'dart:async';

import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'RegesterScreen.dart';
import 'HomePage.dart';
import 'AdHelper.dart';

void main() { runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => HomeScreen()
            )
        )
    );



  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(int.parse("#055C9D".substring(1, 7), radix: 16) + 0xFF000000),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 200),

            child: Image.asset('assets/images/logo.png',height: 400,width: 500,),

          ),
        ])

    );
  }
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
class HomeScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        color: hexToColor(globalvar.enishialcolor),
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[

            Container(

              margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 0,bottom: 0),

              child: Image.asset('assets/images/logo.png',height: 250,),
            ),

                  Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: const EdgeInsets.only(left: 0.0, right: 0.0,top: 30,bottom: 0),



              child: Card(
                borderOnForeground:false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 40),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Input your email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),),

                    Container(

                        margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 40),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Input your password',
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),),

            Container(
              width: 200
                ,
              height: 40,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 70,bottom: 70),
                    child: RaisedButton(
                      color: hexToColor(globalvar.enishialcolor2),
                      // background
                      textColor: Colors.white, // foreground
                      onPressed: () {
    if(!emailController.text.isEmpty &&passwordController.text.isNotEmpty)
    {
    DatabaseReference _messagesRef2 =
    FirebaseDatabase.instance.reference();
    String fullemail="";

    _messagesRef2.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value.toString()}');
    fullemail='Data : ${snapshot.value.toString()}';
    }).then((value) =>


          //globalvar.name=emailController.text;
         /* ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('جار تسجيل الدخول'))),*/
                        globalvar.email=emailController.text


    ).whenComplete(() =>

{
    if(fullemail.contains(emailController.text)  && fullemail.contains(passwordController.text+formatsrting(emailController.text))){

        Navigator.push(context,
        MaterialPageRoute(builder: (context) => MainPage()),)

     /* ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('true'))),

        Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen()),),*/




    } else
    {

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('البريد الالكتروني او رمز المرور خطأ')))

    }});


                      }
                      },
                      child: Text('Login'),
                    )
            ),

                    Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10),
                    child: TextButton(onPressed: (){

                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegesterScreen()),);

                    }, child: Text('You Don\'t have account ?')))

                  ],
                ),
              )


          ),




                ])),
      ));
  }
  String formatsrting(String len) {
    String len2=len.replaceAll('@', '');
    len2=len2.replaceAll('.', '');
    return len2;
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}



