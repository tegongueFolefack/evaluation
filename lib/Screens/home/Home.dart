// import 'package:attendance/Screens/Matiere/ListMatiere.dart';
// import 'package:attendance/Screens/Salle/ListSalle.dart';
// import 'package:attendance/Screens/login/login.dart';
// import 'package:attendance/Utils/constantes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../Models/Salle/Salle.dart';
// import '../../Services/SalleService.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late Animation<double> _animation2;

//   late SharedPreferences _prefs;
//   late int _userId;
//   late String _username;
//   late int _isConnected;

//   SalService salService = SalService();

//   List<SalleModel> salleList = [];

//   Future<dynamic> fetchData() async{
//     salleList = await salService.getOneByEns(_userId);
//     setState(() {});
//   }

//   // Initialise SharedPreferences
//   _initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//     // Récupérer l'ID et le nom d'utilisateur stockés localement
//     setState(() {
//       _userId = _prefs.getInt('userId') ?? 0;
//       _username = _prefs.getString('username') ?? '';
//       _isConnected = _prefs.getInt('isConnected') ?? 0;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initPrefs();
//     fetchData();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );

//     _animation = Tween<double>(begin: 0, end: 1)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
//       ..addListener(() {
//         setState(() {});
//       });

//     _animation2 = Tween<double>(begin: -30, end: 0)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _controller.forward();
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Color(0xD7FCFDFD),
//       body: Stack(
//         children: [
//           /// ListView
//           ListView(
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             children: [
//               Padding(
//                 padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _username,
//                       style: TextStyle(
//                         fontSize: 27,
//                         color: Colors.black.withOpacity(.6),
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     SizedBox(height: _w / 35),
//                     const Center(child: Icon(Icons.emoji_emotions_outlined, size: 40, color: Colors.deepOrange)),
//                     Text(
//                       'Que voulez - vous faire aujourd\'hui ?',
//                       style: TextStyle(
//                         fontSize: 19,
//                         color: Colors.black.withOpacity(.5),
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.start,
//                     ),
//                   ],
//                 ),
//               ),
//               homePageCardsGroup(
//                 const Color(0xfff37736),
//                 Icons.home_filled,
//                 'Mes Salles',
//                 context,
//                 ListSalle(),
//                 const Color(0xffFF6D6D),
//                 Icons.class_,
//                 'Mes Matieres',
//                 const ListMatiere(),
//               ),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               cards(),
//               SizedBox(height: _w / 20),
//             ],
//           ),
//           CustomPaint(
//             painter: MyPainter(),
//             child: Container(height: 0),
//           ),

//           /// SETTING ICON
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, _w / 9.5, _w / 15, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: () {
//                     HapticFeedback.lightImpact();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MyCustomLoginUI()),
//                     );
//                   },
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(99)),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
//                       child: Container(
//                         height: _w / 8.5,
//                         width: _w / 8.5,
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(.05),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.settings,
//                             size: _w / 17,
//                             color: Colors.black.withOpacity(.6),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Blur the Status bar
//           Methode.blurTheStatusBar(context),
//         ],
//       ),
//     );
//   }

//   Widget homePageCardsGroup(
//       Color color,
//       IconData icon,
//       String title,
//       BuildContext context,
//       Widget route,
//       Color color2,
//       IconData icon2,
//       String title2,
//       Widget route2) {
//     double _w = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: EdgeInsets.only(bottom: _w / 17),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           homePageCard(color, icon, title, context, route),
//           homePageCard(color2, icon2, title2, context, route2),
//         ],
//       ),
//     );
//   }

//   Widget homePageCard(Color color, IconData icon, String title,
//       BuildContext context, Widget route) {
//     double _w = MediaQuery.of(context).size.width;
//     return Opacity(
//       opacity: _animation.value,
//       child: Transform.translate(
//         offset: Offset(0, _animation2.value),
//         child: InkWell(
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           onTap: () {
//             HapticFeedback.lightImpact();
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return route;
//                 },
//               ),
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.all(15),
//             height: _w / 2,
//             width: _w / 2.4,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xff040039).withOpacity(.15),
//                   blurRadius: 99,
//                 ),
//               ],
//               borderRadius: BorderRadius.all(
//                 Radius.circular(25),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(),
//                 Container(
//                   height: _w / 8,
//                   width: _w / 8,
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: color.withOpacity(.6),
//                   ),
//                 ),
//                 Text(
//                   title,
//                   maxLines: 4,
//                   softWrap: true,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black.withOpacity(.5),
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget cards() {
//     double _w = MediaQuery.of(context).size.width;
//     return Opacity(
//       opacity: _animation.value,
//       child: Transform.translate(
//         offset: Offset(0, _animation2.value),
//         child: InkWell(
//           enableFeedback: true,
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ListMatiere(),
//                 ));
//           },
//           highlightColor: Colors.white,
//           splashColor: Colors.transparent,
//           child: Container(
//             margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
//             padding: EdgeInsets.all(_w / 15),
//             height: _w / 3.4,
//             width: _w,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xffffffff),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.blue.withOpacity(.1),
//                   radius: _w / 15,
//                   child: FlutterLogo(size: 30),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   width: _w / 2,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Example',
//                         textScaleFactor: 1.6,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black.withOpacity(.7),
//                         ),
//                       ),
//                       Text(
//                         'Example',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black.withOpacity(.8),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.navigate_next_outlined)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyPainter extends CustomPainter {
// @override
// void paint(Canvas canvas, Size size) {
// Paint paint_1 = Paint()
// ..color = Color(0xffF57752)
// ..style = PaintingStyle.fill;

// Path path_1 = Path()
// ..moveTo(0, 0)
// ..lineTo(size.width * .1, 0)
// ..cubicTo(size.width * .05, 0, 0, 20, 0, size.width * .08);

// Path path_2 = Path()
// ..moveTo(size.width, 0)
// ..lineTo(size.width * .9, 0)
// ..cubicTo(
// size.width * .95, 0, size.width, 20, size.width, size.width * .08);

// Paint paint_2 = Paint()
// ..color = Color(0xffF57752)
// ..strokeWidth = 1
// ..style = PaintingStyle.stroke;

// Path path_3 = Path()
// ..moveTo(0, 0)
// ..lineTo(size.width, 0);

// canvas.drawPath(path_1, paint_1);
// canvas.drawPath(path_2, paint_1);
// canvas.drawPath(path_3, paint_2);
// }

// @override
// bool shouldRepaint(covariant CustomPainter oldDelegate) {
// return true;
// }
// }