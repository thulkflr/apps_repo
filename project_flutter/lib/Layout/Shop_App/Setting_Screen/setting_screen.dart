import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Component/const_component.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/states.dart';

import '../../../Styles/colors.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var oldPasswordController = TextEditingController();

  var newPasswordController = TextEditingController();
  late bool updateFormVisible;

  void initState() {
    updateFormVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).userModel;

        nameController.text = model.dataa!.name!;
        emailController.text = model.dataa!.email!;
        phoneController.text = model.dataa!.phone!;

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Center(
                                child: Text(
                              nameController.text[0].toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            )),
                            backgroundColor: defaultColor,
                            radius: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nameController.text,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    phoneController.text,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(child: options(Icons.summarize, 'Your Orders'),onTap: (){

                    },),
                    InkWell(child: options(Icons.local_offer_sharp, 'Offers'),onTap: (){

                    }),
                    InkWell(child: options(Icons.notifications, 'Notifications'),onTap: (){

                    }),
                    InkWell(child: options(Icons.paypal, 'Paypal Pay'),onTap: (){

                    }),
                    InkWell(child: options(Icons.live_help, 'Get Help'),onTap: (){

                    }),
                    InkWell(child: options(Icons.info, 'About'),onTap: (){

                    }),
                    InkWell(child: options(Icons.exit_to_app, 'Logout'),onTap: (){
                      signOut(context);
                    }),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: mySeparator(),
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: !updateFormVisible,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                Text(
                                  '    To Update your information ',
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        updateFormVisible = !updateFormVisible;
                                      });
                                    },
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Visibility(
                          visible: updateFormVisible,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  updateFormVisible = false;
                                });
                              },
                              child: Text(
                                'close',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                    Visibility(
                      visible: updateFormVisible,
                      child: Column(
                        children: [
                          if (state is LoadingUpdateUserDataState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameController,
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.person),
                              hintText: 'Name',
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'name must not be empty'
                                : null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.email),
                              hintText: 'Email',
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'email must not be empty'
                                : null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: phoneController,
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.phone),
                              hintText: 'Phone Number',
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Phone Number must not be empty'
                                : null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: 400,
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle),
                            child: MaterialButton(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              color: Colors.blueGrey,
                              child: Text(
                                'UPDATE',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLayoutCubit.get(context).updateUsersData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phoneNumber: phoneController.text);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: oldPasswordController,
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.lock),
                              hintText: 'Current Password',
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'must not be empty' : null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: newPasswordController,
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.password),
                              hintText: 'New Password',
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'must not be empty' : null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: 400,
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle),
                            child: MaterialButton(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              color: Colors.blueGrey,
                              child: Text(
                                'Change Password',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLayoutCubit.get(context).changePassword(
                                      oldPassword: oldPasswordController.text,
                                      newPassword: newPasswordController.text);

                                  if (state is SuccessUpdatePasswordDataState) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Password Updated'),
                                      duration: Duration(seconds: 2),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(ShopLayoutCubit.get(context)
                                          .passwordModel
                                          .message
                                          .toString()),
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

Widget options(IconData iconData, String text) {
  // IconData icon;
  // String text;

  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData),
            SizedBox(
              width: 10,
            ),
            Text(text)
          ],
        ),
        SizedBox(
          height: 30,
        )
      ],
    ),
  );
}
