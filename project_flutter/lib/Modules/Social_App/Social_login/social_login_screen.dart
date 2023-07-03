import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class Social_Login_Screen extends StatelessWidget {
     Social_Login_Screen({super.key});
 var formKey = GlobalKey<FormState>();


     final emailController = TextEditingController();

     final passwordController = TextEditingController();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Center(
           child: SingleChildScrollView(
             child: Padding(
               padding: EdgeInsets.all(10),
               child: Form(
                 key: formKey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'LOGIN',
                       style: TextStyle(
                           fontSize: 40, fontWeight: FontWeight.bold),
                     ),
                     Text(
                       'Login To Show The Best Food Ever',
                       style:
                       TextStyle(fontSize: 10, color: Colors.grey),
                     ),
                     Padding(
                         padding: const EdgeInsets.fromLTRB(
                             0.0, 30.0, 0.0, 0.0),
                         child: TextFormField(
                           controller: emailController,
                           maxLines: 1,
                           keyboardType: TextInputType.emailAddress,
                           autofocus: false,
                           decoration: InputDecoration(
                               border: OutlineInputBorder(),
                               hintText: 'Email',
                               icon: Icon(
                                 Icons.mail,
                                 color: Colors.grey,
                               )),
                           validator: (value) => value!.isEmpty
                               ? 'Email can\'t be empty'
                               : null,
                         )),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(
                           0.0, 15.0, 0.0, 0.0),
                       child: TextFormField(
                         controller: passwordController,
                         maxLines: 1,
                         obscureText:
                         ShopLoginCubit.get(context).isPassword,
                         autofocus: false,
                         decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             hintText: 'Password',
                             icon: Icon(
                               Icons.lock,
                               color: Colors.grey,
                             )),
                         validator: (value) => value!.isEmpty
                             ? 'Password can\'t be empty'
                             : null,
                       ),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Container(
                       height: 40,
                       width: double.infinity,
                       decoration:
                       BoxDecoration(shape: BoxShape.rectangle),
                       child: ConditionalBuilder(
                         condition: state is! LoadingLoginStates,
                         builder: (context) => MaterialButton(
                           elevation: 5.0,
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(2)),
                           color: Colors.blueGrey,
                           child: Text(
                             'LOGIN',
                             style: TextStyle(color: Colors.white),),
                           onPressed: () {
                             if (formKey.currentState!.validate()) {
                               ShopLoginCubit.get(context).userLogin(
                                   email: emailController.text,
                                   password: passwordController.text);
                             } else {
                               print('null');
                             }
                           },
                         ),
                         fallback: (BuildContext context) =>
                             Center(child: CircularProgressIndicator()),
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.symmetric(vertical: 15),
                       child: Row(
                         children: [
                           Text(
                             'Do not have an account? ',

                           ),TextButton(onPressed: (){navigateAndReplacment(context,ShopRegisterScreen() );}, child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold),))
                         ],
                       ),
                     ),
                     Visibility(
                       visible: false,
                       child: Padding(
                         padding: EdgeInsets.symmetric(vertical: 20),
                         child: Row(
                           children: [
                             TextButton.icon(
                               icon: Icon(Icons.looks_one),
                               label: Text('Sign In With Google'),
                               onPressed: () async {},
                             )
                           ],
                         ),
                       ),
                     ),
                     Visibility(
                       visible: false,
                       child: Padding(
                         padding: EdgeInsets.symmetric(vertical: 20),
                         child: Row(
                           children: [
                             TextButton.icon(
                               icon: Icon(Icons.facebook),
                               label: Text('Sign In With Facebook'),
                               onPressed: () async {},
                             )
                           ],
                         ),
                       ),
                     )
                   ],
                 ),
               ),
             ),
           ),
         ),
       ),
     );
   }
 }
 