import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AdHelper.dart';
import 'partclasses.dart';
import 'videolist.dart';

// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';

class AboutUs extends StatelessWidget  {


  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("من نــحن"),backgroundColor: hexToColor(globalvar.enishialcolor2),),
        body: Center(


            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                  ' هو تطبيق مجاني متاح للاستخدام مؤسس التطبيق الدكتور ظاهر لفا , حيث يعتبر التطبيق بمثابة مدرسة خاصة لتعليم مناهج الثاني ثانوي او التوجيهي الاردني من الالف الى الياء بكل احرافية وسهولة'
                +  ', يستخدم التطبيق الوسائط الالكترونية الاحدث والافضل لايصال افضل صورة ممكنة للمناهج الدراسية , ليتمكن الطالب من الدراسة من منزله وبشكل مجاني , كما يساهم التطبيق في توفير الكثير من الوقت والجهد والكلفة المادية  ',
              textDirection:TextDirection.rtl,))

   ));}

   Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}