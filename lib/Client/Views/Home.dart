// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:blood/Client/Views/RequestDonor.dart';
// import 'package:blood/models/Donars.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Client extends StatefulWidget {
//   const Client({Key? key}) : super(key: key);

//   @override
//   State<Client> createState() => _ClientState();
// }

// class _ClientState extends State<Client> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   signOut() async {
//     Navigator.pop(context);
//     await auth.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text("Make Choice here"),
//       ),
//       // ignore: prefer_const_constructors
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 48.0),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     AvatarGlow(
//                         curve: Curves.elasticOut,
//                         duration: const Duration(seconds: 5),
//                         glowColor: Colors.red[300]!,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) => const Donars(),
//                                   fullscreenDialog: true),
//                             );
//                           },
//                           child: const CircleAvatar(
//                             radius: 60,
//                             child: Text("View Donors"),
//                           ),
//                         ),
//                         endRadius: 100),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     AvatarGlow(
//                         curve: Curves.elasticOut,
//                         duration: const Duration(seconds: 5),
//                         glowColor: Colors.red[300]!,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) => const ,
//                                   fullscreenDialog: true),
//                             );
//                           },
//                           child: const CircleAvatar(
//                             radius: 60,
//                             child: Text("Blood request"),
//                           ),
//                         ),
//                         endRadius: 100),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         // ignore: sized_box_for_whitespace
//         child: Container(
//           width: MediaQuery.of(context).size.width / 3,
//           height: MediaQuery.of(context).size.height,
//           child: ListView(
//             children: [
//               UserAccountsDrawerHeader(
//                 currentAccountPicture: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Image.asset("images/donate.png"),
//                 ),
//                 accountName: Text("Client: ${auth.currentUser!.email}"),
//                 accountEmail: Text("${auth.currentUser!.email}"),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.request_quote),
//                 title: const Text("View Donors"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const Donars(),
//                       fullscreenDialog: true,
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 // ignore: prefer_const_constructors
//                 leading: Icon(
//                   Icons.logout_rounded,
//                 ),
//                 title: const Text("Sign out"),
//                 onTap: () => signOut(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
