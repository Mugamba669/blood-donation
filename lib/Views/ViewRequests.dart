// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewRequests extends StatefulWidget {
  const ViewRequests({Key? key}) : super(key: key);

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  // ignore: slash_for_doc_comments
  /****Displays the requests sent */
  CollectionReference<Map<String, dynamic>> requestStore =
      FirebaseFirestore.instance.collection('requests');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: InkWell(
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("View Request"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 5,
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
        child: Center(
          child: StreamBuilder(
            stream: requestStore.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );

              return (!snapshot.hasData)
                  ? const Center(
                      child: Text("No records found"),
                    )
                  : ListView(
                      children: snapshot.data!.docs
                          .map((document) => Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(document['group']),
                                  ),
                                  subtitle: Text(document['date']),
                                  title: Text(document['name']),
                                  trailing: Text(document['quantity']),
                                ),
                              ))
                          .toList());
            },
          ),
        ),
      ),
    );
  }
}
