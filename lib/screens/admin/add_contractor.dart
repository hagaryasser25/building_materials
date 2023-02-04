import 'dart:io';
import 'package:building_materials/screens/admin/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class AddContractor extends StatefulWidget {
  static const routeName = '/addContractor';
  const AddContractor({super.key});

  @override
  State<AddContractor> createState() => _AddContractorState();
}

class _AddContractorState extends State<AddContractor> {
  var codeController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var descriptionController = TextEditingController();
  var companyController = TextEditingController();
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 50.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'كود المقاول',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'اسم المقاول',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'رقم هاتف المقاول',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'السيرة الذاتية',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: companyController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'اسم الشركة',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () async {
                        String name = nameController.text.trim();
                        String description = descriptionController.text.trim();
                        String company = companyController.text.trim();
                        String phoneNumber = phoneNumberController.text.trim();
                        String code = codeController.text.trim();

                        if (name.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل اسم المقاول');
                          return;
                        }

                        if (description.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل السيرة الذاتية للمقاول');
                          return;
                        }

                        if (company.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'ادخل اسم الشركة');
                          return;
                        }

                        if (code.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل كود المقاول');
                          return;
                        }

                        if (phoneNumber.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل رقم هاتف المقاول');
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;
                          int date = DateTime.now().millisecondsSinceEpoch;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('contractors');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'name': name,
                            'code': code,
                            'description': description,
                            'companyName': company,
                            'phoneNumber': phoneNumber,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child: Text('حفظ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم أضافة المقاول'),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
