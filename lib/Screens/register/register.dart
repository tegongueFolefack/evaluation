// import 'package:attendance/Screens/home/Home.dart';
// import 'package:attendance/Screens/login/login.dart';
// import 'package:attendance/Services/EnseignantService.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../Models/Enseignant/Enseignant.dart';
// import '../../Utils/constantes.dart';

// class MyCustomRegisterUI extends StatefulWidget {
//   const MyCustomRegisterUI({
//     String? errorMessage, Key? key
//     }) : _errorMessage= errorMessage, super(key: key);

//   final String? _errorMessage;

//   @override
//   _MyCustomRegisterUIState createState() => _MyCustomRegisterUIState();
// }

// class _MyCustomRegisterUIState extends State<MyCustomRegisterUI>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   late TextEditingController _nomController;
//   late TextEditingController _matriculeController;
//   late TextEditingController _pwdController;
//   late TextEditingController _prenomController;
//   late TextEditingController _telController;
//   late TextEditingController _mailController;
//   late TextEditingController _anneeController;

//   late SharedPreferences _prefs;
//   late int _userId ;
//   late String _username ;
//   late int _isConnected ;

//   @override
//   void initState() {
//     super.initState();
//     _initPrefs();
//     _nomController = TextEditingController();
//     _matriculeController = TextEditingController();
//     _pwdController = TextEditingController();
//     _prenomController = TextEditingController();
//     _telController = TextEditingController();
//     _mailController = TextEditingController();
//     _anneeController = TextEditingController();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     _animation = Tween<double>(begin: .7, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.ease,
//       ),
//     )
//       ..addListener(
//             () {
//           setState(() {});
//         },
//       )
//       ..addStatusListener(
//             (status) {
//           if (status == AnimationStatus.completed) {
//             _controller.reverse();
//           } else if (status == AnimationStatus.dismissed) {
//             _controller.forward();
//           }
//         },
//       );

//     _controller.forward();
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
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: const Color(0xff292C31),
//       body: ScrollConfiguration(
//         behavior: MyBehavior(),
//         child: SingleChildScrollView(
//           child: SizedBox(
//             height: height,
//             child: Column(
//               children: [
//                 const Expanded(child: SizedBox()),
//                 Expanded(
//                   flex: 4,
//                   child: SafeArea(
//                     child:
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const SizedBox(),
//                       const Text(
//                         "S'INSCRIRE",
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xffA9DED8),
//                         ),
//                       ),
//                       const SizedBox(), const Spacer(),
//                       Methode.component1(Icons.account_circle_outlined, 'Matricule',
//                           false, false, _matriculeController, context, TextInputType.text),
//                       const Spacer(),
//                       Methode.component1(Icons.person, 'Nom',
//                           false, false, _nomController, context, TextInputType.name),
//                       const Spacer(),
//                       Methode.component1(Icons.person, 'Prenom',
//                           false, false, _prenomController, context, TextInputType.name),
//                       const Spacer(),
//                       Methode.component1(Icons.email_outlined, 'Email...', false, true, _mailController, context, TextInputType.emailAddress),
//                       const Spacer(),
//                       Methode.component1(Icons.phone_android, 'Telephone',
//                           false, false, _telController, context, TextInputType.phone),
//                       const Spacer(),
//                       Methode.component1(
//                           Icons.lock_outline, 'Mot de pass...', true, false, _pwdController, context, TextInputType.text),
//                       const Spacer(),
//                       Methode.component1(
//                           Icons.date_range, 'Entrance Year', false, false, _anneeController, context, TextInputType.datetime),
//                       const Spacer(),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                               text: "J'ai deja un compte",
//                               style: const TextStyle(
//                                 color: Color(0xffA9DED8),
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCustomLoginUI()));
//                                 },
//                             ),
//                           ),
//                         ],
//                       ), const Spacer(),
//                 Expanded(
//                   flex: 3,
//                   child: Stack(
//                     children: [
//                       Center(
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: width * .07),
//                           height: width * .7,
//                           width: width * .7,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 Colors.transparent,
//                                 Color(0xff09090A),
//                               ],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Transform.scale(
//                           scale: _animation.value,
//                             child: Container(
//                               height: width * .2,
//                               width: width * .2,
//                               alignment: Alignment.center,
//                               decoration: const BoxDecoration(
//                                 color: Color(0xffA9DED8),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: ElevatedButton(
//                                 style: const ButtonStyle(
//                                   backgroundColor: null,
//                                   elevation: null
//                                 ),
//                                 onPressed: () async {
//                                   EnsService service = EnsService();
//                                   var response;
//                                   EnseignantModel e = EnseignantModel(
//                                       matriculeEns: _matriculeController.text,
//                                       nomEns: _nomController.text,
//                                       prenomEns: _prenomController.text,
//                                       telEns: _telController.text,
//                                       mailEns: _mailController.text,
//                                       pwd: _pwdController.text,
//                                       startingYear: int.parse(_anneeController.text));
//                                   response = await service.saveEtudiant(e);
//                                   if (response != null) {
//                                     _saveUserData(response.idEns, response.nomEns.toUpperCase() + " " + response.prenomEns.toUpperCase(), 1);
//                                     setState(() {
//                                       (response.idEns != null) ? Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()))
//                                       : Fluttertoast.showToast(
//                                         msg: 'Shared preferences not set',
//                                       );
//                                     });
//                                   } else {
//                                     setState(() {
//                                       HapticFeedback.lightImpact();
//                                       Fluttertoast.showToast(
//                                         msg: "Echec de l'enregistrement, reessayer",
//                                       );
//                                     });
//                                   }
//                                 },
//                                   child: const Text(
//                                 'Save',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),const Spacer(),
//                     ],
//                   )
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Sauvegarder l'ID et le nom d'utilisateur dans SharedPreferences
//   _saveUserData(int userId, String username, int isConnected) async {
//     setState(() {
//       _userId = userId;
//       _username = username;
//       _isConnected = isConnected;
//     });
//     await _prefs.setInt('userId', userId);
//     await _prefs.setString('username', username);
//     await _prefs.setInt("isConnected", isConnected);
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
