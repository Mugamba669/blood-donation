import 'dart:io';

import 'package:blood/Views/ViewRequests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:hive_flutter/adapters.dart';

class RegisterDonar extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  RegisterDonar({Key? key}) : super(key: key);

  @override
  _RegisterDonarState createState() => _RegisterDonarState();
}

class _RegisterDonarState extends State<RegisterDonar> {
  CollectionReference<Map<String, dynamic>> store =
      FirebaseFirestore.instance.collection("donars");

  var bloodGroupController = TextEditingController();
  String? name;
  double? longitude;
  double? latitude;
  String? group;
  String? phoneNumber;
  @override
  void dispose() {
    bloodGroupController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // store.add(data)
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  void signOutUser() async {
    await auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 23,
          color: Colors.white,
        ),
        title: const Text(
          "Donation details",
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 4,
                color: Colors.black,
                offset: Offset(-4, -0.2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: widget.formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        initialValue: "",
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: "Provide your name",
                        ),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Name is required",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: bloodGroupController,
                        onTap: () => showBloodGroups(),
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Blood Group",
                        ),
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : "Blood Group is required",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        initialValue: "",
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: "Phone number",
                        ),
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : "Phone number  is required",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType: TextInputType.number,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          labelText: "Longitude",
                        ),
                        onChanged: (value) {
                          setState(() {
                            longitude = double.parse(value);
                          });
                        },
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Longitude is required",
                      ),
                    ),
                    TextFormField(
                      //  textInputAction: TextInputAction.next,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      keyboardType: TextInputType.number,
                      initialValue: "",
                      maxLength: 100,
                      decoration: const InputDecoration(
                        labelText: "Latitude",
                      ),
                      onChanged: (value) {
                        setState(() {
                          latitude = double.parse(value);
                        });
                      },
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Latitude is required",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(300, 30),
                            ),
                          ),
                          child: const Text("Register"),
                          onPressed: onFormSubmit,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.zero,
        child: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("images/donate.png"),
                ),
                accountName: Text("Signed in as ${auth.currentUser!.email}"),
                accountEmail: const Text(""),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_add_alt_1_rounded),
                title: const Text('View request details'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => ViewRequests(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () => signOutUser(),
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.exit_to_app_rounded),
                  title: const Text('Quit'),
                  onTap: () => exit(0)),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  List<String> groups = ["A+", "A-", "B", "B+", "AB", "B-", "O"];
  void showBloodGroups() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheet(
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ListView(
                    children: List.generate(
                      groups.length,
                      (index) => ListTile(
                        hoverColor: Colors.black38,
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            group = groups[index];
                            bloodGroupController.text = groups[index];
                          });
                        },
                        title: Center(
                          child: Text(
                            groups[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  void onFormSubmit() {
    if (widget.formKey.currentState!.validate()) {
      var storage = {
        'name': name,
        'group': bloodGroupController.text,
        'latitude': latitude,
        'longitude': longitude,
        'contact': phoneNumber
      };
      store.add(storage);
      // widget.formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(label: "Ok", onPressed: () {}),
          dismissDirection: DismissDirection.up,
          behavior: SnackBarBehavior.floating,
          content: Text("$name was registered sucessfully"),
        ),
      );
      setState(() {
        bloodGroupController.text = "";
      });
      widget.formKey.currentState!.reset();
      Navigator.of(context).push(
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => ViewRequests(),
          fullscreenDialog: true,
        ),
      );
    }
  }
}
