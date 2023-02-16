// import 'dart:developer';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:sdk_flutter_07_2022_firebase/lib_organizer.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final GlobalKey<State> _keyLoader = GlobalKey<State>();
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   String userEmail = '';
//
//   final UserService service = UserService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(10),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Hero(
//                   tag: 'hero',
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
//                     child: CircleAvatar(
//                       backgroundColor: Colors.transparent,
//                       radius: 48.0,
//                       child: Image.network(
//                           'https://raw.githubusercontent.com/ageelbaraa/SDK/main/LOGO/SDK.png'),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
//                     child: TextFormField(
//                       controller: _email,
//                       maxLines: 1,
//                       keyboardType: TextInputType.emailAddress,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                           hintText: 'Email',
//                           icon: Icon(
//                             Icons.mail,
//                             color: Colors.grey,
//                           )),
//                       validator: (value) =>
//                       value!.isEmpty ? 'Email can\'t be empty' : null,
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                   child: TextFormField(
//                     controller: _password,
//                     maxLines: 1,
//                     obscureText: true,
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         hintText: 'Password',
//                         icon: Icon(
//                           Icons.lock,
//                           color: Colors.grey,
//                         )),
//                     validator: (value) =>
//                     value!.isEmpty ? 'Password can\'t be empty' : null,
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//                     child: SizedBox(
//                       height: 40.0,
//                       child: RaisedButton(
//                         elevation: 5.0,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0)),
//                         color: Colors.blue,
//                         child: Text('Login',
//                             style:
//                             TextStyle(fontSize: 20.0, color: Colors.white)),
//                         onPressed: () async {
//                           validateAndSignIn();
//                         },
//                       ),
//                     )),
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     child: RichText(
//                       text: TextSpan(
//                           text: 'Do not have an account? ',
//                           style: TextStyle(color: Colors.black, fontSize: 18),
//                           children: [
//                             TextSpan(
//                                 text: 'Sign Up',
//                                 style: TextStyle(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.bold),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.of(context)
//                                         .pushNamed(signUpRoute);
//                                   })
//                           ]),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: false,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       children: [
//                         TextButton.icon(
//                           icon: Icon(Icons.looks_one),
//                           label: Text('Sign In With Google'),
//                           onPressed: () async {},
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: false,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       children: [
//                         TextButton.icon(
//                           icon: Icon(Icons.facebook),
//                           label: Text('Sign In With Facebook'),
//                           onPressed: () async {},
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void validateAndSignIn() async {
//     if (_formKey.currentState!.validate()) {
//       var email = _email.text.trim();
//       var password = _password.text.trim();
//       var result = await service.signIn(email, password);
//       if (result.isNotEmpty) {
//         // get user
//         var model = await service
//             .getUser(result)
//             .whenComplete(() => Navigator.of(context).pushNamed(usersRoute));
//         // if (model != null) {
//         //   Navigator.of(context).pushNamed(profileRoute, arguments: model);
//         // } else {
//         //   Navigator.of(context).pushNamed(profileRoute, arguments: UserModel());
//         // }
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Validation error')));
//     }
//   }
// }