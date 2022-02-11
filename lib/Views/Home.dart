import 'dart:io';

import 'package:blood/Auth/RegisterDonars.dart';
import 'package:blood/Views/ViewRequests.dart';
import 'package:blood/map/Map.dart';
import 'package:blood/models/Donars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  void signOutUser() async {
    Navigator.pop(context);
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Life Save ",
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),

          child: const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: SizedBox(
                height: 450,
                width: 300,
                child: MapView(),
              ),
            ),
          ),
        ),
      ),
      // ignore: prefer_const_constructors, avoid_unnecessary_containers
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
              ListTile(
                leading: const Icon(Icons.view_agenda_rounded),
                title: const Text('View Donors'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => Donars(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_add_alt_1_rounded),
                title: const Text('Register Donors'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => RegisterDonar(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ViewRequests(),
              fullscreenDialog: true,
            ),
          );
        },
        // ignore: prefer_const_constructors
        icon: Icon(
          Icons.pin_drop_rounded,
        ),
        label: const Text("View Requests"),
      ),
    );
  }
}
