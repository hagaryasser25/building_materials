import 'package:building_materials/models/complains_model.dart';
import 'package:building_materials/models/contractList_model.dart';
import 'package:building_materials/screens/admin/admin_replay.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class AdminComplains extends StatefulWidget {
  static const routeName = '/adminComplains';
  const AdminComplains({super.key});

  @override
  State<AdminComplains> createState() => _AdminComplainsState();
}

class _AdminComplainsState extends State<AdminComplains> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Complains> complainsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchComplains();
  }

  @override
  void fetchComplains() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("userComplains");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Complains p = Complains.fromJson(event.snapshot.value);
      complainsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(backgroundColor: Colors.green, title: Text('الشكاوى')),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 10.w,
              left: 10.w,
            ),
            child: ListView.builder(
              itemCount: complainsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 15, bottom: 10),
                          child: Column(children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'الشكوى : ${complainsList[index].description.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'حساب المشتكى : ${complainsList[index].userEmail.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120.w, height: 35.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    child: Text('الرد على الشكوى'),
                                    onPressed: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AdminReplay(
                                          complain: '${complainsList[index].description.toString()}',
                                          email: '${complainsList[index].userEmail.toString()}',
                                          
                                        );
                                      }));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 50.w,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120.w, height: 35.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    child: Text('مسح الشكوى'),
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  super.widget));
                                      base
                                          .child(complainsList[index]
                                              .id
                                              .toString())
                                          .remove();
                                    },
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String getDate(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);

    return DateFormat('MMM dd yyyy').format(dateTime);
  }
}
