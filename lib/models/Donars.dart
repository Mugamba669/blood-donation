// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:blood/Views/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Donars extends StatelessWidget {
  final String bloodGroup;
  Donars({Key? key, required this.bloodGroup}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  double latitude = 0.0;
  double longitude = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
        toolbarHeight: 100,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Available donars'),
      ),
      // ignore: avoid_unnecessary_containers
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            // ignore: prefer_const_constructors
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('donars').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              if (!snapshot.hasData)
                return const Center(
                  child: Text("Oops! No donors yet...."),
                );
              else
                return ListView(
                    children: snapshot.data!.docs
                        .map((response) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Home(
                                            lat:
                                                response['latitude'].toString(),
                                            long: response['longitude']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      child: Text(response['group']),
                                    ),
                                    title: Text(response['name']),
                                    subtitle: Text(response['contact']),
                                    trailing: InkWell(
                                      onTap: () {
                                        _makePhoneCall(response['contact']);
                                      },
                                      child: const CircleAvatar(
                                          child: Icon(Icons.phone)),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList());
            },
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton.extended(
            // ignore: prefer_const_constructors
            label: Text("View Map"),
            icon: const Icon(Icons.map_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Home(
                    lat: latitude,
                    long: longitude,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
