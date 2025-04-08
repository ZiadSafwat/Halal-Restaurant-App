// import 'package:animated_introduction/animated_introduction.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wave_nfc_app/ViewModel/MQLProvider.dart';
// import 'package:wave_nfc_app/pages/signInScreen.dart';
//
// class AboutApp extends StatefulWidget {
//   const AboutApp({super.key, required this.isFirstTime});
//   final bool isFirstTime;
//
//   @override
//   State<AboutApp> createState() => _AboutAppState();
// }
//
// final List<SingleIntroScreen> pages = [
//   const SingleIntroScreen(
//     title: 'Welcome to  Waves App !',
//     description:
//         'Tap into the future of networking with Waves NFC cards, combining convenience and innovation.',
//     imageAsset: 'assets/Asset1.png',
//   ),
//   const SingleIntroScreen(
//     title: 'Instant sharing, effortless connections',
//     description:
//         'Elevate your business game with Waves NFC cards – where technology meets simplicity.',
//     imageAsset: 'assets/Asset2.png',
//   ),
//   const SingleIntroScreen(
//     title: 'Your brand, one tap away',
//     description: 'Ready to upgrade your networking game? Order your custom NFC card now – reach us on WhatsApp:+201143030465.',
//     imageAsset: 'assets/Asset3.png',
//   ),
// ];
//
// class _AboutAppState extends State<AboutApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedIntroduction(doneText:widget.isFirstTime?'Login Now':'Done' ,
//         slides: pages,
//         indicatorType: IndicatorType.circle,
//         onDone: () async {
//           if (widget.isFirstTime) {
//             await context
//                 .read<UserViewModel>()
//                 .prefs
//                 .setBool('firstOrNot', false);
//             await context
//                 .read<UserViewModel>()
//                 .isThisFirstTime();
//
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SignInScreen(),
//                 ));
//           } else {
//             if (Navigator.of(context).canPop()) {
//               Navigator.of(context).pop();
//             }
//           }
//         },
//       ),
//     );
//
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:path/path.dart';
// // import 'package:provider/provider.dart';
// // import 'package:untitled3/ViewModel/MQLProvider.dart';
// //
// // import '../models/users.dart';
// //  import 'addpage.dart';
// // import 'editpage.dart';
// //
// //
// //
// // class ListPage extends StatefulWidget {
// //   const ListPage({super.key});
// //
// //   @override
// //   State<StatefulWidget> createState() {
// //     return _ListPage();
// //   }
// // }
// //
// // class _ListPage extends State<ListPage> {
// //   // final Stream<QuerySnapshot> collectionReference = context.read<MQLProvider>().readUser('pinfdcbjsz');
// //   //FirebaseFirestore.instance.collection('Employee').snapshots();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       appBar: AppBar(
// //         title: const Text("List of Employee"),
// //         backgroundColor: Theme.of(context).primaryColor,
// //         actions: <Widget>[
// //           IconButton(
// //             icon: const Icon(
// //               Icons.app_registration,
// //               color: Colors.white,
// //             ),
// //             onPressed: () {
// //               Navigator.pushAndRemoveUntil<dynamic>(
// //                 context,
// //                 MaterialPageRoute<dynamic>(
// //                   builder: (BuildContext context) => const AddPage(),
// //                 ),
// //                     (route) =>
// //                 false, //if you want to disable back feature set to false
// //               );
// //             },
// //           )
// //         ],
// //       ),
// //       body:
// //             (context.read<MQLProvider>().user!=null)  ?
// //               Padding(
// //               padding: const EdgeInsets.only(top: 8.0),
// //               child: ListView(
// //                 children:  .map((e) {
// //                   return Card(
// //                       child: Column(children: [
// //                         ListTile(
// //                           title: Text(e["name"]),
// //                           subtitle: Container(
// //                             child: (Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: <Widget>[
// //                                 Text('phoneNumber: ' + e['phoneNumber'].toString(),
// //                                     style: const TextStyle(fontSize: 14)),
// //                                 Text("facebook: " + e['facebook'],
// //                                     style: const TextStyle(fontSize: 12)),
// //                               ],
// //                             )),
// //                           ),
// //                         ),
// //                         ButtonBar(
// //                           alignment: MainAxisAlignment.spaceBetween,
// //                           children: <Widget>[
// //                             TextButton(
// //                               style: TextButton.styleFrom(
// //                                 foregroundColor: const Color.fromARGB(255, 143, 133, 226), padding: const EdgeInsets.all(5.0),
// //                                 textStyle: const TextStyle(fontSize: 20),
// //                               ),
// //                               child: const Text('Edit'),
// //                               onPressed: () {
// //                                 Navigator.pushAndRemoveUntil<dynamic>(
// //                                   context,
// //                                   MaterialPageRoute<dynamic>(
// //                                     builder: (BuildContext context) => const EditPage(
// //
// //                                     ),
// //                                   ),
// //                                       (route) =>
// //                                   false, //if you want to disable back feature set to false
// //                                 );
// //                               },
// //                             ),
// //
// //                           ],
// //                         ),
// //                       ]));
// //                 }).toList(),
// //               ),
// //             ):
// //
// //
// //             Container();
// //         },
// //     ,
// //     );
// //   }
// // }
