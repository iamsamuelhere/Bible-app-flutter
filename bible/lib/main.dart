import 'package:bible/screens/newtest.dart';
import 'package:bible/screens/oldtest.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Home(),
      routes:{
         "/old":(context)=>Old(),
         "/new":(context)=>New(),

        

      }
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Read Bible"),
        SizedBox(width:10.0),
        Icon(FontAwesomeIcons.book)
      ],),
      
      backgroundColor: Colors.red,),
      
    body:ListView(
      children: [
        GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card( 
                      elevation: 25.0,
            child: Image(image: AssetImage("images/oldtest.jpg"),)
      ),
                  ),
      onTap: (){
       Navigator.pushNamed(context, '/old');
      },
        ),
            GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card( 
                      elevation: 25.0,

          child: Image(image: AssetImage("images/new.jpg"),)
      ),
                          ),
          onTap: (){
       Navigator.pushNamed(context, '/new');
      },
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
        Text("Made with ",style: TextStyle(color:Colors.teal),),
        Icon(Icons.favorite,color: Colors.red),
        Text(" by Sam",style: TextStyle(color:Colors.teal),),

      ],)
      ],
    )
    );
  }
}