import 'package:building_materials/screens/auth/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

import '../user/user_home.dart';
import 'admin_login.dart';
import 'contractor_login.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(
                'assets/images/building.jfif',
                height: 180.h,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          '?????????? ????????',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 75.h,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                border: OutlineInputBorder(),
                                hintText: '???????????? ????????????????????',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 75.h,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: passwordController,
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.password, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                border: OutlineInputBorder(),
                                hintText: '???????? ????????????',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: double.infinity, height: 50.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 237, 210, 75),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: Text(
                              '?????? ????????',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 89, 175, 245),
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'Please fill all fields');
                                return;
                              }

                              ProgressDialog progressDialog = ProgressDialog(
                                  context,
                                  title: Text('Logging In'),
                                  message: Text('Please Wait'));
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (userCredential.user != null) {
                                  progressDialog.dismiss();
                                  Navigator.pushNamed(
                                      context, UserHome.routeName);
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  Fluttertoast.showToast(msg: 'User not found');
                                } else if (e.code == 'wrong-password') {
                                  Fluttertoast.showToast(msg: 'Wrong password');
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: 'Something went wrong');
                                progressDialog.dismiss();
                              }
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //Navigator.pushNamed(context, SignUp.routeName);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 35.w, top: 20.h),
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AdminLogin.routeName);
                                    },
                                    child: Text(
                                      '?????????? ???????????? ??????????',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ContractorLogin.routeName);
                                    },
                                    child: Text(
                                      '?????????? ???????????? ????????????',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignUpPage.routeName);
                            },
                            child: Text(
                              '???? ???????????? ???????? ???? ??????',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
