// import 'dart:html';

import 'dart:convert';

import 'package:voyage/Profile/CreatProfile.dart';

import '../Blog/Blogs.dart';
import '../Model/ProfilMo.dart';
import '../Model/profileModel.dart';
import '../NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainProfile extends StatefulWidget {
  MainProfile({Key key}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();

  // List<ProfileModel> total = [];
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/api/v1/profile");
    setState(() {
      // print(body["data"][0]);
      // print(response.body);
      // final Iterable v = response["id"];
// total = (list.map((m)=>profileModel.form)
      // final parsed = JsonCodec.withReviver(response)as Map;
      // print("$parsed hhhhhhhhfdfffkkkkkkkkkkkkkkkkkkkkkkkkkk");
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }
  // ignore: missing_return
  // Future<List<ProfileM>> fetchData() async {
  // var response = await http.get(Uri.parse("/api/v1/profile" as String));
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        //   color: Colors.black,
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatProfile(),
                                  ));
                                  },
            color: Colors.black,
          ),
        ],
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                head(),
                Divider(
                  thickness: 0.8,
                ),
                otherDetails("About", profileModel.about),
                otherDetails("Name", profileModel.name),
                otherDetails("Profession", profileModel.profession),
                otherDetails("DOB", profileModel.DOB),
                Divider(
                  thickness: 0.8,
                ),
                SizedBox(
                  height: 20,
                ),
                // Blogs(
                //   url: "/blogpost/getOwnBlog",
                // ),
              ],
            ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkHandler().getImage(profileModel.name),
            ),
          ),
          Text(
            profileModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            profileModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(profileModel.titleline)
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
