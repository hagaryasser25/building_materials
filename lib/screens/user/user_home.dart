import 'package:building_materials/screens/auth/login.dart';
import 'package:building_materials/screens/user/user_building.dart';
import 'package:building_materials/screens/user/user_cart.dart';
import 'package:building_materials/screens/user/user_complain.dart';
import 'package:building_materials/screens/user/user_contractor.dart';
import 'package:building_materials/screens/user/user_finishing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/users_model.dart';

class UserHome extends StatefulWidget {
  String email;
  String name;
  static const routeName = '/userHome';
  UserHome({required this.email, required this.name});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    late DatabaseReference base;
    late FirebaseDatabase database;
    late FirebaseApp app;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('الصفحة الرئيسة'),
          ),
          drawer: Drawer(
              child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Text("${widget.name}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 20.h),
                    Text("${widget.email}",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () {
                          // Navigator.pushNamed(
                          // context, UserDoctor.routeName);
                        },
                        title: Text('الصفحة الرئيسة'),
                        leading: Icon(Icons.home),
                      ))),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, UserCart.routeName);
                        },
                        title: Text('طلبيات الشراء'),
                        leading: Icon(Icons.shopping_cart),
                      ))),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, UserContractor.routeName);
                        },
                        title: Text('التواصل مع المقاولين'),
                        leading: Icon(Icons.contact_mail),
                      ))),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, UserComplain.routeName);
                        },
                        title: Text('الشكاوى'),
                        leading: Icon(Icons.ads_click),
                      ))),
              Divider(
                thickness: 0.80,
                color: Colors.grey,
              ),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('تأكيد'),
                                  content: Text('هل انت متأكد من تسجيل الخروج'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushNamed(
                                            context, LoginPage.routeName);
                                      },
                                      child: Text('نعم'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('لا'),
                                    ),
                                  ],
                                );
                              });
                        },
                        title: Text('تسجيل الخروج'),
                        leading: Icon(Icons.exit_to_app_rounded),
                      ))
                      )
            ],
          )),
          body: Column(
            children: [
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
                          height: 70.h,
                        ),
                        Text(
                          'أختر القسم',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, right: 10.w, left: 10.w),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, UserBuilding.routeName);
                                  },
                                  child: card('مواد البناء', '#e8b823')),
                              SizedBox(
                                width: 10.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, UserFinishing.routeName);
                                  },
                                  child: card('مواد التشطيبات', '#ed872d')),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(String text, String color) {
  return Container(
    child: Card(
      color: HexColor(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 150.w,
        height: 250.h,
        child: Center(
            child: Text(text,
                style: TextStyle(fontSize: 18, color: Colors.black))),
      ),
    ),
  );
}
