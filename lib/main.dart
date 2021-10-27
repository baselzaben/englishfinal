import 'dart:async';

import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'RegesterScreen.dart';
import 'HomePage.dart';
import 'AdHelper.dart';
import 'package:share/share.dart';
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
class SplashScreenState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;



  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => HomeScreenPage()
            )
        )
    );
   // late final AnimationController _controller;
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat();

  }
  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.jpg"),
        fit: BoxFit.cover,
      ),
    ),
     //   color: Color(int.parse("#055C9D".substring(1, 7), radix: 16) + 0xFF000000),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
     /*     AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.14159265358979323846,
                child: child,
              );
            },*/
           Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 200),

              child: Image.asset('assets/images/logo.png',height: 400,width: 500,),

            ),
         // ),

        ])

    );
  }
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class HomeScreenPage extends StatefulWidget{
  HomeScreen createState()=> HomeScreen();
}

class HomeScreen extends State<HomeScreenPage> {
  bool rememberme = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getuserdata();
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),


        height: double.infinity,
      //  color: hexToColor(globalvar.enishialcolor),
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
                    labelText: 'البريد الالكتروني',
                    hintText: 'ادخل بريدك الالكتروني',
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
                          labelText: 'رمز المرور',
                          hintText: 'ادخل رمز المرور',
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),),


                   /* Align(
                        alignment: Alignment.topLeft,
                      child: Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: rememberme,
                          checkColor: Colors.white,

                          onChanged:(bool? value) {
                            setState(() {
                              //   trans();
                              //_valueCheck = value;
                              rememberme=value!; });
                          },
                          activeColor: Theme.of(context).primaryColor),
                    ),
*/
                    Container(
                      margin: const EdgeInsets.only(left: 12.0,right: 12.0,top: 5.0,bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: rememberme,
                              checkColor: Colors.white,

                              onChanged:(bool? value) {
                                setState(()   {
                                  //   trans();
                                  //_valueCheck = value;
                                  rememberme=value!;
                                  checkremeber(rememberme);
                                });
                              },
                              activeColor: Theme.of(context).primaryColor),
                          //Text("تذكر معلومات الدخول")
                          //  Text(lan.getTexts('login').toString())
                          Text('تــذكرني')
                        ],
                      ),
                    ),



            Container(
              width: 200
                ,
              height: 40,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 20,bottom: 70),
                    child: RaisedButton(
                      color: hexToColor(globalvar.enishialcolor2),
                      // background
                      textColor: Colors.white, // foreground
                      onPressed: () async {




                        if(!emailController.text.isEmpty &&passwordController.text.isNotEmpty)
    { setuserdata(emailController.text,passwordController.text);
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
        Navigator.pop(context),

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
                      child: Text('تسجيل الدخول'),
                    )
            ),

                    Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10),
                    child: TextButton(onPressed: (){

                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegesterScreen()),);

                    }, child: Text('لا تملك حساب ?')))

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
  void getuserdata()async{
    SharedPreferences prefer;

    prefer = await SharedPreferences.getInstance();
    bool? x=prefer.getBool('rememberme');
if(x!=null)
  if(x){
    var userid = prefer.getString('pass');
    var password = prefer.getString('email');

    emailController.text=userid!;
    passwordController.text=password!;
  }
  }


  void setuserdata(String em,String pa)async{
    SharedPreferences prefer;

    prefer = await SharedPreferences.getInstance();

  prefer.setString('pass',em);
   prefer.setString('email',pa);


  }

 checkremeber(bool rememberme) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberme',rememberme);

  }

/*  getcheckremember() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('rememberme');
  }*/


}



