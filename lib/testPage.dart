import 'package:englishfinal/globalvar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'partclasses.dart';
import 'videolist.dart';
import 'showvidopage.dart';
import 'testPage.dart';

class testPage extends StatefulWidget {
  var rout='';
  var title='';
  var k='';
  var go='';
  var _result;
  var emailcompleted='';
  DatabaseReference _messagesRef =FirebaseDatabase.instance.reference().child('items').child('en').child('items') ;

  testPage(var rout,String go,String k,String emailcompleted){
    this.rout=rout;
    this.title=title;
    this.k=k;
    this.go=go;
    this.emailcompleted=emailcompleted;
    _messagesRef= FirebaseDatabase.instance.reference().child('items').child(globalvar.homeselecteditem).child('items').child(go).child('videos').child(k).child('test');

    _testPageState(rout,go,k,emailcompleted);

  }//I don't know what is this index for but I will put it in anyway
  @override
  _testPageState createState() => _testPageState(rout,go,k,emailcompleted);
}

class _testPageState extends State<testPage> {
  var rout='';
  var title='';
  var go='';  var emailcompleted='';

  var _result;  var k='';

  DatabaseReference _messagesRef =FirebaseDatabase.instance.reference() ;

  _testPageState(var rout,String go,String k,String emailcompleted){
    this.rout=rout;
    this.go=go;
    this.title=title; this.k=k;
    this.emailcompleted=emailcompleted;
   // _messagesRef= FirebaseDatabase.instance.reference().child('items').child("ar").child('items').child("part1").child('videos').child("v1").child('test');
    _messagesRef= FirebaseDatabase.instance.reference().child('items').child(globalvar.homeselecteditem).child('items').child(go).child('videos').child(k).child('test');

  }
  List ansers = [];
  List Q = [];
  List AT = [];
  int astindex=0;

  List length = [];

int result=0;
  int index=0;
String correct="";
  int selectedRadio = -1;

  changeValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }


  @override
  Widget build (BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('????????????????????'),backgroundColor: hexToColor(globalvar.enishialcolor2),   shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),),
      body: FutureBuilder(
        future: _messagesRef.once(),

        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return new Text('Loading....');
          print("fdgdfgfdgfdgdf "+rout +"-"+ go +"-"+k);
          List selected =[];

          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          print("fdgdfgfdgfdgdf "+rout +"-"+ go +"-"+k);

          snapshot.data.value.forEach(
                  (_, values) => Q.add(values["Q"])
          );
          List A1 = [];
          snapshot.data.value.forEach(
                  (_, values) => A1.add(values["A1"])
          );
          List A2 = [];
          snapshot.data.value.forEach(
                  (_, values) => A2.add(values["A2"])
          );
          List A3 = [];
          snapshot.data.value.forEach(
                  (_, values) => A3.add(values["A3"])
          );


          snapshot.data.value.forEach((_, values) => AT.add(values["AT"])
          );

         snapshot.data.value.forEach((_, values) => selected.add("0")
          );


          globalvar.lastindex=Q.length-1;
          length.add((Q.length-1).toString());
            print(Q.length.toString()+"THIS IS LENGTH NNNNNNNNNNNNNN");
          return Container(
            height: double.infinity,
            color: hexToColor(globalvar.enishialcolor),
                // onTap: () => selectItem(scannedItemsValues[index],scannedItemspath[index],scannedItemsmailcomplted[index],globalvar.email,context),
                  child: Container(

                    margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 10),

                    child: Card(
                        color:  Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                              children: <Widget>[

                    Padding(
                          padding: EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: Text((index+1).toString(),style: TextStyle(color:  hexToColor(globalvar.enishialcolor),fontSize: 20),),
                                ),
                              ),

                            Container(
                          margin: const EdgeInsets.only(bottom: 15),
                           child: Text(Q[index],style: TextStyle(color:  Colors.black,fontSize: 20),),
                                     ),
                              Container(
                                width:MediaQuery.of(context).size.width ,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black54,  ),
                                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10,bottom: 5),
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0,bottom: 0),
                                  child:TextButton(onPressed: (){
                                    nextquestion(A1[index],context);
                                  }, child: Text(A1[index],style: TextStyle(color: Colors.white,fontSize: 15),))),


                              Container(
                                  width:MediaQuery.of(context).size.width ,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black54,  ),
                                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0,bottom: 0),
                                  child:TextButton(onPressed: (){
                                    nextquestion(A2[index],context);
                                  }, child: Text(A2[index],style: TextStyle(color: Colors.white,fontSize: 15),))),



                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black54,  ),
                                  width:MediaQuery.of(context).size.width ,

                                  margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0,bottom: 0),
                                  child:TextButton(onPressed: (){
                                    nextquestion(A3[index],context);
                                  }, child: Text(A3[index],style: TextStyle(color:  Colors.white,fontSize: 15),))),
////////////////////////////////////////////

                            /////////////////////////////////////////////////

                              SizedBox(height: 25),
                            //  Text(AT[index] == ansers[index] ? 'Correct!' : 'Please chose the right answer!')
                              Text(correct)
                            ],
                          )),
                 ] ),
                        ))));


        },
      ),

    );
  }
  selectItem(String name,String path,String emailcompleted,String email,BuildContext context,String go) {
    print(emailcompleted);
    print(formatsrting(email));
    if (formatsrting(email).contains(formatsrting((email)))) {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('compleeete')));
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => showvideopage(name,path,emailcompleted,k,go)),);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('noooot compleeeted')));
    }

  }

  Widget  checkcomplet(String name,String path,String emailcompleted,String email,BuildContext context) {
    if (formatsrting(email).contains(formatsrting((email)))) {
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
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  nextquestion(String anser,BuildContext context){
    setState(() {
       int x=0;
       x=int.parse(length[0])+1;
      ansers.add(anser);
      if(index.toString()==length[0]){
       // getreslutexam();
       if(AT[index].toString()==ansers[index].toString())
          result++;
       String r="";
       r="???????????? ???? ";
       r=r+" $result";
       r=r+" ???? ";
       r=r+x.toString();
if(result>=int.parse(length[0])/2 )
   {
     if(!(addemailcomplete(k,x)=='null')){
     Navigator.of(context).pop();
     _showDialog(context,r,Colors.green);
   _messagesRef= FirebaseDatabase.instance.reference().child('items').child(globalvar.homeselecteditem).child('items').child(go).child('videos').child(addemailcomplete(k,x));
   _messagesRef.update({
     'emailscompleted': emailcompleted+formatsrting(globalvar.email),
   });
   }else {
       Navigator.of(context).pop();
       _showDialog(context, r, Colors.green);
     }}
else {
  Navigator.of(context).pop();
  _showDialog(context, r, Colors.redAccent);
}
      }else{
        if(AT[index].toString()==ansers[index].toString())
          result++;
      index++;

        print(index.toString()+"  indesx");
        print( ansers.length.toString()+"  length");

      }
    });
  }

  void _showDialog(BuildContext context,String result,Color c) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
    /*      title: new Text("???????? ????????????????",),
          content: new Text(result,style: TextStyle(color: c),),
*/
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 9,right: 9,left: 9),
                child: Center(child: Image.asset('assets/images/logo.png',height: 200,),)),
          //  Container( margin: const EdgeInsets.only(top: 9,right: 9,left: 9), child: Text("?????????? ????????????????",style: TextStyle(fontSize: 20),),),
            Container( margin: const EdgeInsets.only(bottom: 9,right: 9,left: 9,top: 5),  child: Center(child: Text(result,style: TextStyle(color: c,fontSize: 22),)),),

            new FlatButton(
              color: hexToColor(globalvar.enishialcolor2),
              child: new Text("??????????",style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  String addemailcomplete(String v,int lengthquestion) {
    String index=v.substring(1,v.length);
    int x=int.parse(index)+1;
    if(x<=lengthquestion)
   { index="v"+x.toString();
    return index;
   }
    return 'null';

  }
}


