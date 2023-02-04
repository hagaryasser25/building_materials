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

class BookContractor extends StatefulWidget {
  String code;
  static const routeName = '/bookContractor';
  BookContractor({required this.code});

  @override
  State<BookContractor> createState() => _BookContractorState();
}

class _BookContractorState extends State<BookContractor> {
  var descriptionController = TextEditingController();
  var deliveryDateController = TextEditingController();
  var addressController = TextEditingController();
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late String email;

  @override
  void initState() {
    // TODO: implement initState
    email = FirebaseAuth.instance.currentUser!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maxLines = 5;
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
                    height: 150.h,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 10,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الشغل المطلوب',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: deliveryDateController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تاريخ التسليم',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'عنوان العقار',
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
                        String description = descriptionController.text.trim();
                        String deliveryDate =
                            deliveryDateController.text.trim();
                        String address = addressController.text.trim();

                        if (description.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل الشغل المطلوب');
                          return;
                        }

                        if (deliveryDate.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل تاريخ التسليم');
                          return;
                        }

                        if (address.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل عنوان العقار');
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;
                          int date = DateTime.now().millisecondsSinceEpoch;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('bookContractors');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'userEmail': email,
                            'code': widget.code,
                            'date': date,
                            'description': description,
                            'deliveryDate': deliveryDate,
                            'address': address,
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
    content: Text('تم ارسال استمارة التعاقد'),
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
