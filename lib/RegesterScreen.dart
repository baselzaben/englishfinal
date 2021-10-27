import 'dart:convert';
import 'dart:math';

import 'package:englishfinal/globalvar.dart';
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
      body:Container(
        color: hexToColor(globalvar.enishialcolor),

        child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[

                      Container(

                        height: 300,
                        width:300,
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 0,bottom: 0),
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0,top: 40,bottom: 0),

                        child: Image.asset('assets/images/logo.png'),
                      ),

                      Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0,bottom: 20),
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0,top: 20,bottom: 0),


                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 20),

                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: namedController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(20),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'الاسم',
                                      hintText: 'أدخل اسمك',
                                      prefixIcon: Icon(Icons.account_box_rounded),
                                    ),
                                  ),),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 20),

                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,

                                    controller: emailController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(20),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'البريد الالكتروني',
                                      hintText: 'ادخل بريدك الالكتروني',
                                      prefixIcon: Icon(Icons.email),

                                    ),
                                  ),),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 20),

                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,

                                   // validator: Validators.min(5, 'Value less than 5 not allowed'),
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(20),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'رمز المرور',
                                      hintText: 'ادخل رمز المرور',

                                      prefixIcon: Icon(Icons.password),
                                    ),
                                  ),),

                                Container(
                                    width: 200
                                    ,
                                    height: 40,
                                    margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 70,bottom: 50),
                                    child: RaisedButton(
                                      color: hexToColor(globalvar.enishialcolor2),

                                      textColor: Colors.white, // foreground
                                      onPressed: () {

if(!namedController.text.isEmpty &&namedController.text.isNotEmpty&&!namedController.text.isEmpty &&emailController.text.contains("@")&& emailController.text.contains("."))
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
            SnackBar(content: Text('هذا البريد موجود بالفعل')))
    } else
        {

          _messagesRef.child(getRandString(8)).set({
            'name': namedController.text.toString(),
            'email': emailController.text.toString(),
            'password': passwordController.text+formatsrting(emailController.text)
          }).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم التسجيل , اذهب لتسجيل الدخول')));
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
        SnackBar(content: Text('اكمل تعبئة المعلومات')));
}
                                      },
                                      child: Text('تسجيل'),
                                    )
                                ),

                                Container(
                                    margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10),
                                    child: TextButton(onPressed: (){

                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomeScreenPage()),);

                                    }, child: Text(' هل تملك حساب بالفعل ?')))

                              ],
                            ),
                          )


                      ),




                    ])),
      )
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
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}