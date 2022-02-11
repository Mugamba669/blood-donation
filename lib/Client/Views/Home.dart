// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:blood/Client/Views/RequestDonor.dart';
import 'package:blood/models/Donars.dart';
import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  Client({Key? key}) : super(key: key);

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AvatarGlow(
                curve: Curves.elasticOut,
                duration: const Duration(seconds: 5),
                glowColor: Colors.red[300]!,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RequestDonor(),
                          fullscreenDialog: true),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    child: Text("Request Donor"),
                  ),
                ),
                endRadius: 100),
          ),
        ),
      ),
      drawer: Drawer(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("Client"),
                accountEmail: Text(""),
              ),
              ListTile(
                leading: const Icon(Icons.request_quote),
                title: const Text("View Donors"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Donars(),
                        fullscreenDialog: true,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
