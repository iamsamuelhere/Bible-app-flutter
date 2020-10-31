import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class New extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

String drpval = "Matthew";
final TextEditingController selectedchapter = TextEditingController();
int userselchap;
final TextEditingController selectedverse = TextEditingController();
int userselverse;
DropdownMenuItem chaptername(String name) {
  return DropdownMenuItem(
    child: Text("$name"),
    value: name,
  );
}

class _NewState extends State<New> {
  List<DropdownMenuItem> chapters = [
    chaptername("Matthew"),
    chaptername("Mark"),
    chaptername("Luke"),
    chaptername("John"),
    chaptername("Acts of the Apostles"),
    chaptername("Romans"),
    chaptername("1 Corinthians"),
    chaptername("2 Corinthians"),
    chaptername("Galatians"),
    chaptername("Ephesians"),
    chaptername("Philippians"),
    chaptername("Colossians"),
    chaptername("1 Thessalonians"),
    chaptername("2 Thessalonians"),
    chaptername("1 Timothy"),
    chaptername("2 Timothy"),
    chaptername("Titus"),
    chaptername("Philemon"),
    chaptername("Hebrews"),
    chaptername("James"),
    chaptername("1 Peter"),
    chaptername("2 Peter"),
    chaptername("1 John"),
    chaptername("2 John"),
    chaptername("3 John"),
    chaptername("Jude"),
    chaptername("Revelation"),
   
  ];

  dynamic verse;
  void make(int chap, int selverse) async {
    String url = "https://bible-api.com/" + drpval + "+$chap" + ":$selverse";
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var jsonResponse = convert.jsonDecode(response.body);

    setState(() {
      verse = jsonResponse["verses"][0]["text"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Testement"),

        ),
        body:SingleChildScrollView(
                  child: Column(
            children: [ Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              Text("Chapter: ${userselchap==null?"0":userselchap}",style: TextStyle(fontSize: 35.0,color: Colors.teal),),
              SizedBox(width:20.0),
              Text("Verse:${userselverse==null?"0":userselverse}",style: TextStyle(fontSize: 35.0,color: Colors.teal),)
           
            ],),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                children: [
                  Opacity(
                      opacity: 0.9,
                      child: Container(
                       color: Colors.teal,
                        child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${verse==null?'not valid':verse}",style: TextStyle(color:Colors.white,fontSize: 20.0),),
                        )
                      ))
                ],
              ),
                          ),
              DropdownButton(
                  value: drpval,
                  items: chapters,
                  onChanged: (val) {
                    setState(() {
                      drpval = val;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: selectedchapter,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Select Chapter",
                      hintText: "Enter Chapter"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: selectedverse,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Select Verse",
                      hintText: "Enter Verse"),
                ),
              ),
              Row(children: [
                Expanded(child: RaisedButton(
                  splashColor: Colors.teal,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(FontAwesomeIcons.backward,color: Colors.teal,),
                    SizedBox(width:20.0),
                    Text("Previous Verse")
                  ],) 
                  
                  
                  ,onPressed: (){
                  setState(() {
                    userselverse--;
                    make(userselchap, userselverse);
                  });
                },)),
                Expanded(
                  
                  child: RaisedButton(
                  splashColor: Colors.teal,
                    
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next Verse"),
                       SizedBox(width:20.0),
                    Icon(FontAwesomeIcons.forward,color: Colors.teal,),
                   
                    
                  ],),onPressed: (){
                        setState(() {
                    userselverse++;
                    make(userselchap, userselverse);
                  });
                },))

              ],),
              RaisedButton(
                  splashColor: Colors.teal,

                  onPressed: () {
                    userselchap = int.parse(selectedchapter.text);
                    userselverse = int.parse(selectedverse.text);

                    make(userselchap, userselverse);
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(FontAwesomeIcons.readme,color: Colors.teal,),
                    SizedBox(width:20.0),
                    Text("Read now")
                  ],) 
                  
                  
                  ),
                   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
        Text("Made with ",style: TextStyle(color:Colors.teal),),
        Icon(Icons.favorite,color: Colors.red),
        Text(" by Sam",style: TextStyle(color:Colors.teal),),

      ],)

            ],
          ),
        ));
  }
}
