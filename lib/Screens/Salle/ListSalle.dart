// import 'dart:developer';

// import 'package:attendance/Models/Salle/Salle.dart';
// import 'package:attendance/Services/SalleService.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class ListSalle extends StatefulWidget {
//   ListSalle({super.key});

//   @override
//   State<ListSalle> createState() => _ListSalleState();
// }

// class _ListSalleState extends State<ListSalle> {

//   SalService salService = SalService();
//   List<SalleModel> salleList = [];
//   late SharedPreferences _prefs;
//   late int _userId ;

//   Future<dynamic> fetchData() async{
//     salleList = await salService.getOneByEns(_userId);
//     setState(() {});
//   }

//   // Initialise SharedPreferences
//   _initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _userId = _prefs.getInt('userId') ?? 0;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initPrefs();
//     fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _w = MediaQuery.of(context).size.width;
//     int columnCount = 3;

//     return Scaffold(
//         appBar: AppBar(
//             backgroundColor: const Color(0x02DAA7FF),
//             elevation: 50,
//             centerTitle: true,
//             shadowColor: Colors.black.withOpacity(.5),
//             title: Text(
//               'Mes Salles de cours',
//               style: TextStyle(
//                   color: Colors.black.withOpacity(.7),
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1),
//             ),
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.black.withOpacity(.8),
//               ),
//               onPressed: () => Navigator.maybePop(context),
//             ),
//             ),
//       body: AnimationLimiter(
//         child: GridView.count(
//           physics:
//           BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//           padding: EdgeInsets.all(_w / 60),
//           crossAxisCount: columnCount,
//           children: List.generate(
//             salleList?.length ?? 0,
//                 (int index) {
//               return AnimationConfiguration.staggeredGrid(
//                 position: index,
//                 duration: Duration(milliseconds: 500),
//                 columnCount: columnCount,
//                 child: ScaleAnimation(
//                   duration: Duration(milliseconds: 900),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   scale: 1.5,
//                   child: FadeInAnimation(
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           bottom: _w / 30, left: _w / 60, right: _w / 60),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 40,
//                             spreadRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Text(salleList[index].codeSalle),
//                           Text(salleList[index].nbrePlace.toString())
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//         );
//     }
// }