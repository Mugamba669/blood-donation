import 'package:blood/Global/Global.dart';
import 'package:blood/Views/Home.dart';
import 'package:blood/map/Map.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Donar.dart';

class Donars extends StatelessWidget {
  const Donars({Key? key}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

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
            Navigator.pop(context);
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
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Donar>(dnt).listenable(),
            builder: (context, Box<Donar> box, _) {
              if (box.values.isEmpty)
                // ignore: curly_braces_in_flow_control_structures
                return const Center(
                  child: Text("Oops! No donors...."),
                );
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  Donar? currentContact = box.getAt(index);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(currentContact!.bloodGroup),
                          ),
                          title: Text(currentContact.name),
                          subtitle: Text(currentContact.contact),
                          trailing: InkWell(
                            onTap: () {
                              _makePhoneCall(currentContact.contact);
                            },
                            child: const CircleAvatar(child: Icon(Icons.phone)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
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
                  builder: (context) => const Home(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
