import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signUpPage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
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
              Image.asset('assets/images/building.jfif',height: 180.h,),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Text(
                            'تسجيل حساب',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 75.h,
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: fullNameController,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.white),
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
                                  hintText: 'الاسم',
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
                              controller: addressController,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.ac_unit, color: Colors.white),
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
                                  hintText: 'العنوان',
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
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.phone, color: Colors.white),
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
                                  hintText: 'الهاتف',
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
                                  hintText: 'البريد الألكترونى',
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
                                  hintText: 'كلمة المرور',
                                  hintStyle: TextStyle(color: Colors.white)),
                              obscureText: true,
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
                                'سجل حساب',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 89, 175, 245),
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () async{
                                var fullName = fullNameController.text.trim();
                                var phoneNumber =
                                    phoneNumberController.text.trim();
                                var email = emailController.text.trim();
                                var password = passwordController.text.trim();
                                var address = addressController.text.trim();

                                if (fullName.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty ||
                                    phoneNumber.isEmpty ||
                                    address.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Please fill all fields');
                                  return;
                                }
                                if (password.length < 6) {
                                  // show error toast
                                  Fluttertoast.showToast(
                                      msg:
                                          'Weak Password, at least 6 characters are required');

                                  return;
                                }

                                ProgressDialog progressDialog = ProgressDialog(
                                    context,
                                    title: Text('Signing Up'),
                                    message: Text('Please Wait'));
                                progressDialog.show();

                                try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          UserCredential userCredential =
                              await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          User? user = userCredential.user;
                          user!.updateProfile(displayName: fullName);

                          if (userCredential.user != null) {
                            DatabaseReference userRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('users');

                            String uid = userCredential.user!.uid;
                            int dt = DateTime.now().millisecondsSinceEpoch;

                            await userRef.child(uid).set({
                              'fullName': fullName,
                              'email': email,
                              'uid': uid,
                              'dt': dt,
                              'phoneNumber': phoneNumber,
                              'address': address,
                            });

                            Fluttertoast.showToast(msg: 'Success');

                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(msg: 'Failed');
                          }
                          progressDialog.dismiss();
                        } on FirebaseAuthException catch (e) {
                          progressDialog.dismiss();
                          if (e.code == 'email-already-in-use') {
                            Fluttertoast.showToast(
                                msg: 'Email is already exist');
                          } else if (e.code == 'weak-password') {
                            Fluttertoast.showToast(msg: 'Password is weak');
                          }
                        } catch (e) {
                          progressDialog.dismiss();
                          Fluttertoast.showToast(msg: 'Something went wrong');
                        }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          )
                        ],
                      ),
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
