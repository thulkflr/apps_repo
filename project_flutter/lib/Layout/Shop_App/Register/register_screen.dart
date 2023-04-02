import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Login/login_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Register/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Register/Cubit/states.dart';

import '../../../Component/const_component.dart';
import '../../../Network/Remote/shared_helper.dart';
 import '../Shop_Layout/shop_layout.dart';

class ShopRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();


  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();


    ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => ShopSignUPCubit(),
    child: BlocConsumer<ShopSignUPCubit,ShopSignUpStates>
      (
      listener: (context, state) {
        {
          if (state is SuccessSignUpStates) {
            if (state.loginModel.status!) {
              Prefs.saveData(
                  key: 'token', value: state.loginModel.dataa!.token)
                  .then((value) {
                token =state.loginModel.dataa!.token!;// to update on token
                navigateAndReplacment(context, ShopLayout());
              });
            } else {
              showToast(
                  msg: state.loginModel.message.toString(),
                  states: ToastStates.ERORR,context: context);
            }
          }
        }
      },
      builder: (context, state) =>  Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sign Up Now , you will not regert it ,',
                      style:
                      TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0.0, 30.0, 0.0, 0.0),
                        child: TextFormField(
                          controller: nameController,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Your Name',
                              icon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              )),
                          validator: (value) => value!.isEmpty
                              ? 'name can\'t be empty'
                              : null,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0.0, 15.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: emailController,
                        maxLines: 1,

                        autofocus: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            )),
                        validator: (value) => value!.isEmpty
                            ? 'Email can\'t be empty'
                            : null,
                      ),
                    ),   Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0.0, 15.0, 0.0, 0.0),
                        child: TextFormField(
                          controller: phoneNumberController,
                          maxLines: 1,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                              icon: Icon(
                                Icons.phone,
                                color: Colors.grey,
                              )),
                          validator: (value) => value!.isEmpty
                              ? 'Phone Number can\'t be empty'
                              : null,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0.0, 15.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: passwordController,
                        maxLines: 1,
                        obscureText:
                        ShopSignUPCubit.get(context).isPassword,
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
                        condition:state is! LoadingSignUpStates   ,
                        builder: (context) => MaterialButton(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          color: Colors.blueGrey,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopSignUPCubit.get(context).userSignUp(
                                  email: emailController.text,
                                  password: passwordController.text, name: nameController.text,phone: phoneNumberController.text);
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
                            'You already have an account? ',

                          ),TextButton(onPressed: (){navigateTo(context,ShopLoginScreen() );}, child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold),))
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      )
    )
      );
  }
}
