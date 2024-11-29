import 'package:chat_app/backend/Firebaseresponse/Firebaseresponse.dart';
import 'package:chat_app/controller/authcontroller.dart';
import 'package:chat_app/model/authmodel.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/components/Textfield/Textfield.dart';
import 'package:chat_app/views/pages/chat/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _searchcontroller = TextEditingController();

  final _database = database();
  final _usercontroller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatApp"), actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ]),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Textfieldwidget(
            hinttext: "Search",
            controller: _searchcontroller,
            suffixIcon: Icons.search,
            suffic: true,
            sufficontab: () {
              setState(() {});
            },
          ),
          // ---STREAMBUILDER--
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User")
                .where("username", isEqualTo: _searchcontroller.text)
                .where("username", isNotEqualTo: UserController().user.username)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot _data = snapshot.data as QuerySnapshot;
                  if (_data.docs.length > 0) {
                    // -----Listview builder
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // ----userdata
                        Map<String, dynamic> _userdata =
                            _data.docs[index].data() as Map<String, dynamic>;
                        // ---search data--
                        Usermodel _search = Usermodel.fromJson(
                            FirebaseResponseModel(
                                _userdata, _data.docs[index].id),
                            _data.docs[index].id);
                        // ---ListTile---
                        return ListTile(
                            onTap: () async {
                              final chatexists =
                                  await _database.checkchatexists(
                                      _usercontroller.user.uid!, _search.uid!);
                              if (!chatexists) {
                                await _database.newchat(
                                    _usercontroller.user.uid!, _search.uid!);
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Chatview(model: _search)));
                            },
                            title: Text(_search.username!),
                            subtitle: Text(_search.email!));
                      },
                    );
                  } else {
                    return Text("No friends");
                  }
                } else if (snapshot.hasError) {
                  return Text("Error! An error occured");
                } else {
                  return Text("No friends");
                }
              } else {
                return Center(
                  child:
                      SizedBox(height: 18, child: CircularProgressIndicator()),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
