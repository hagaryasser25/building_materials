import 'package:building_materials/screens/admin/admin_building.dart';
import 'package:building_materials/screens/admin/admin_complains.dart';
import 'package:building_materials/screens/admin/admin_contractor.dart';
import 'package:building_materials/screens/admin/admin_finishing.dart';
import 'package:building_materials/screens/admin/contract_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth/login.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('الصفحة الرئيسة'),
          ),
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
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('تأكيد'),
                                              content: Text(
                                                  'هل انت متأكد من تسجيل الخروج'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    FirebaseAuth.instance
                                                        .signOut();
                                                    Navigator.pushNamed(context,
                                                        LoginPage.routeName);
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
                                    child: card('تسجيل الخروج', '#e8b823')),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ContractList.routeName);
                                    },
                                    child: card('استمارات التعاقد', '#ed872d')),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(
                                          context, AdminComplains.routeName);
                                  },
                                  child: card('الشكاوى', '#e8b823')),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AdminContractor.routeName);
                                    },
                                    child: card('بيانات المقوالين', '#ed872d')),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AdminBuilding.routeName);
                                    },
                                    child: card('مواد البناء', '#e8b823')),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AdminFinishing.routeName);
                                    },
                                    child: card('مواد التشطيبات', '#ed872d')),
                              ],
                            ),
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
