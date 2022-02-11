import 'package:blood/Global/Global.dart';
import 'package:blood/models/Request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RequestDonor extends StatefulWidget {
  RequestDonor({Key? key}) : super(key: key);

  @override
  State<RequestDonor> createState() => _RequestDonorState();
}

class _RequestDonorState extends State<RequestDonor> {
  FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    Navigator.pop(context);
    await auth.signOut();
  }

  /// ***Controllers */
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController phoneGroupController = TextEditingController();
  TextEditingController quantityGroupController = TextEditingController();
  var formKeyController = GlobalKey<FormState>(debugLabel: "form");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                  accountName: Text("Client"), accountEmail: Text("")),
              ListTile(
                // ignore: prefer_const_constructors
                leading: Icon(
                  Icons.logout_rounded,
                ),
                title: const Text("Sign out"),
                onTap: () => signOut(),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.red,
      appBar: AppBar(
        // leading: InkWell(),
        toolbarHeight: 100,
        centerTitle: true,
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
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
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

  void onFormSubmit() {
    if (formKeyController.currentState!.validate()) {
      Hive.box<Requests>(request).add(Requests(
        name: nameController.text,
        date: dateController.text,
        group: bloodController.text,
        phone: double.parse(phoneGroupController.text),
        quantity: double.parse(quantityGroupController.text),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your request was sent and saved successfully."),
        ),
      );
      setState(() {
        bloodController.text = "";
      });
      formKeyController.currentState!.reset();
    }
  }
}
