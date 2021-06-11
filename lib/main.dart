
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("widget.title"),
      ),
      body: Center(
          child: (users==null)?CircularProgressIndicator():
      ListView.builder(
          itemCount: (users==null)?0:users.length,
          itemBuilder: (context,index){
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(users[index]['picture']['medium']),
              ),
              title: Text(users[index]['name']['title']+" "+users[index]['name']['last']+" "+users[index]['name']['first']),
              subtitle: Text(users[index]['email']),


            );
          })
    ),
    );
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUsers();
  }


  void loadUsers(){
    String url = "https://randomuser.me/api/?results=10";
    http.get(Uri.parse(url))
        .then((resp){
      setState(() {
        this.users=json.decode(resp.body)['results'];
      });
    }).catchError((e){
      print(e);
    });
  }
}





//">=2.7.0 <3.0.0"