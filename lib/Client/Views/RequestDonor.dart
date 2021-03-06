import 'dart:io';

import 'package:blood/Client/Views/Home.dart';
import 'package:blood/Global/Global.dart';
import 'package:blood/models/Donars.dart';
import 'package:blood/models/Request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RequestDonor extends StatefulWidget {
  const RequestDonor({Key? key}) : super(key: key);

  @override
  State<RequestDonor> createState() => _RequestDonorState();
}

class _RequestDonorState extends State<RequestDonor> {
  /// ***Controllers */
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController phoneGroupController = TextEditingController();
  TextEditingController quantityGroupController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bloodController.dispose();
    dateController.dispose();
    phoneGroupController.dispose();
    quantityGroupController.dispose();
  }

  var formKeyController = GlobalKey<FormState>(debugLabel: "form");
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
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: const Text("Make blood request"),
      ),
      body: SafeArea(
        child: Container(
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
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKeyController,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Name",
                          ),
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Name is required",
                        ),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          controller: quantityGroupController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Quantity (Litres)",
                          ),
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Quantity is required",
                        ),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          maxLength: 10,
                          controller: phoneGroupController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Phone number",
                          ),
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : "Phone number  is required",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: TextFormField(
                            controller: bloodController,
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
                        TextFormField(
                          controller: dateController,
                          keyboardType: TextInputType.datetime,
                          onTap: () => showDatePickerObject(),
                          // ignore: prefer_const_constructors
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Date of Request",
                          ),
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Date is required",
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
                title: const Text('View available donars'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => Donars(
                        bloodGroup: bloodController.text,
                      ),
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
  showBloodGroups() {
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
                            // group = groups[index];
                            bloodController.text = groups[index];
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

  Future<void> showDatePickerObject() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // currentDate: ,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1, 1, 30),
      lastDate: DateTime(2047, 9, 7, 17, 30),
    );
    if (picked != null) {
      setState(() {
        dateController.text = picked
            .toString()
            .replaceAll("00", "")
            .replaceFirst("::", "")
            .replaceFirst(".0", "");
      });
    }
  }

  void onFormSubmit() {
    if (formKeyController.currentState!.validate()) {
      /// Pushing all the request to te database
      FirebaseFirestore.instance.collection('requests').add({
        'name': nameController.text,
        'date': dateController.text,
        'group': bloodController.text,
        'phone': phoneGroupController.text,
        'quantity': quantityGroupController.text
      });
      /*********** */
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your request was sent and saved successfully."),
        ),
      );
      setState(() {
        bloodController.text = "";
      });
      formKeyController.currentState!.reset();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Donars(
            bloodGroup: bloodController.text,
          ),
          fullscreenDialog: true,
        ),
      );
    }
  }
}
