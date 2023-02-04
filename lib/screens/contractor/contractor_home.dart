import 'package:building_materials/screens/auth/login.dart';
import 'package:building_materials/screens/contractor/contractor_list.dart';
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

class ContractorHome extends StatefulWidget {
  static const routeName = '/contractorHome';
  const ContractorHome({
    super.key,
  });

  @override
  State<ContractorHome> createState() => _ContractorHomeState();
}

class _ContractorHomeState extends State<ContractorHome> {
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
                          'الخدمات المتاحة',
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
                                  child: card('تسجيل الخروج', '#ed872d')),
                              SizedBox(
                                width: 10.w,
                              ),
                              InkWell(
                                  onTap: () {
                                     Navigator.pushNamed(
                                     context, ContractorList.routeName);
                                  },
                                  child: card('استمارات التعاقد', '#e8b823')),
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
