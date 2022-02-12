import 'package:blood/Client/Views/Home.dart';
import 'package:blood/Global/Global.dart';
import 'package:blood/models/Request.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ViewRequests extends StatefulWidget {
  const ViewRequests({Key? key}) : super(key: key);

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Client()));
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
          child: ValueListenableBuilder(
              valueListenable: Hive.box<Requests>(request).listenable(),
              builder: (context, Box<Requests> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text("There are requests yet..."),
                  );
                }
                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    // ignore: unused_local_variable
                    Requests? requestData = box.getAt(index);
                    return Card(
                      child: ListTile(
                        subtitle: Text(requestData!.date),
                        title: Text(requestData.name),
                        trailing: Text("${requestData.quantity}"),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
