import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Old extends StatefulWidget {
  @override
  _OldState createState() => _OldState();
}

String drpval = "Genesis";
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

class _OldState extends State<Old> {
  List<DropdownMenuItem> chapters = [
    chaptername("Genesis"),
    chaptername("Exodus"),
    chaptername("Leiticus"),
    chaptername("Numbers"),
    chaptername("Deuteronomy"),
    chaptername("Joshua"),
    chaptername("Judges"),
    chaptername("Ruth"),
    chaptername("1 Samuel"),
    chaptername("2 Samuel"),
    chaptername("1 Kings"),
    chaptername("2 Kings"),
    chaptername("1 Chronicles"),
    chaptername("2 Chronicles"),
    chaptername("Ezra"),
    chaptername("Nehemiah"),
    chaptername("Esther"),
    chaptername("Job"),
    chaptername("Psalms"),
    chaptername("Proverbs"),
    chaptername("Ecclesiastes"),
    chaptername("The Song of Solomon"),
    chaptername("Isaiah"),
    chaptername("Jeremiah"),
    chaptername("Lamentations"),
    chaptername("Ezekiel"),
    chaptername("Daniel"),
    chaptername("Hosea"),
    chaptername("Joel"),
    chaptername("Amos"),
    chaptername("Obadiah"),
    chaptername("Jonah"),
    chaptername("Micah"),
    chaptername("Nahum"),
    chaptername("Habakkuk"),
    chaptername("Zephaniah"),
    chaptername("Haggai"),
    chaptername("Zechariah"),
    chaptername("Malachi")
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
          title: Text("Old Testement"),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
                  child: Column(
            children: [ Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Chapter: ${userselchap==null?"0":userselchap} ",style: TextStyle(fontSize: 35.0,color: Colors.teal),),
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
