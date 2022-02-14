import 'dart:io';

import 'package:blood/Auth/RegisterDonars.dart';
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
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  void signOutUser() async {
    Navigator.pop(context);
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),

          child: const Padding(
            padding: EdgeInsets.all(0),
            child: Center(
              child: MapView(),
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
              builder: (context) => const Donars(),
              fullscreenDialog: true,
            ),
          );
        },
        // ignore: prefer_const_constructors
        icon: Icon(
          Icons.pin_drop_rounded,
        ),
        label: const Text("View Donors"),
      ),
    );
  }
}
