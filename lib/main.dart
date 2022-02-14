import 'package:avatar_glow/avatar_glow.dart';
import 'package:blood/Auth/Authenticate.dart';
import 'package:blood/Client/Auth/ClientAuth.dart';
import 'package:blood/Global/Global.dart';
import 'package:blood/firebase_options.dart';
import 'package:blood/models/Donar.dart';
import 'package:blood/models/Request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Donar>(DonarAdapter());
  Hive.registerAdapter<Requests>(RequestsAdapter());
  /***Database for donars */
  await Hive.openBox<Donar>(dnt);
/****Database for requests */
  await Hive.openBox<Requests>(request);
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  // FirebaseAuth.instance.app.
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ChooseSection(),
    );
  }
}

class ChooseSection extends StatefulWidget {
  const ChooseSection({Key? key}) : super(key: key);

  @override
  State<ChooseSection> createState() => _ChooseSectionState();
}

class _ChooseSectionState extends State<ChooseSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        centerTitle: true,
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w300,
        ),
        title: const Text("Save a Life"),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AvatarGlow(
                        duration: const Duration(seconds: 3),
                        curve: Curves.bounceInOut,
                        showTwoGlows: true,
                        glowColor: Colors.red[300]!,
                        child: InkWell(
                          child: const CircleAvatar(
                            radius: 60,
                            child: Text("Reciptient"),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ClientAuth(),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        endRadius: 120,
                      ),
                    ),
                  ),
                  Padding(
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
                                    builder: (context) => const Authenticate(),
                                    fullscreenDialog: true),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 60,
                              child: Text("Donor"),
                            ),
                          ),
                          endRadius: 100),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
