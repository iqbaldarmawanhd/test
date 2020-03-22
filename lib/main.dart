import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:belajarjson/note.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> _notes = List<Note>();
  Future<List<Note>> fetchNote() async {
    var response = await http.get("http://192.168.100.3/test/test.json");

    var notes = List<Note>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNote().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dalil(index,context){
    return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        "Dalil ibadah",
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Alike",
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        _notes[index].dalil,
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Alike",
                          fontSize: 20.0),
                          maxLines: 50,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(Home());
                        },
                        child: Text(
                          "Kembali",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Alike",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ));
}
    return Scaffold(
      appBar: AppBar(
        title: Text("Jadwal Ibadah Harian"),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.calendar_today, color: Colors.white, size: 30,), onPressed: (){})
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue
              ), 
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.control_point, color: Colors.white, size: 30, ), onPressed: () {}),
                title: Text(_notes[index].title, style: TextStyle(color: Colors.white, fontSize: 20),),
                subtitle: Text(_notes[index].text, style: TextStyle(color: Colors.white, fontSize: 14),),
                trailing: IconButton(
                    icon: Icon(Icons.open_with, color: Colors.white, size: 30, ),
                    onPressed: () {
                      return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      "Dalil dan Video",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Alike",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      "Silahkan pilih pilihan dibawah ini",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Alike",
                          fontSize: 20.0),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _dalil(index, context);
                        },
                        child: Text(
                          "Dalil",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Alike",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          launch(_notes[index].yt);
                        },
                        child: Text(
                          "Youtube",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Alike",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Kembali",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Alike",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ));
                    }),
              ),
            ),
          );
        },
        itemCount: _notes.length,
      ),
    );
  }
}



