import 'package:building_materials/models/contractList_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class ContractList extends StatefulWidget {
  static const routeName = '/contractList';
  const ContractList({super.key});

  @override
  State<ContractList> createState() => _ContractListState();
}

class _ContractListState extends State<ContractList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<ContractListv> contractList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchContracts();
  }

  @override
  void fetchContracts() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bookContractors");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      ContractListv p = ContractListv.fromJson(event.snapshot.value);
      contractList.add(p);
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
          appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('استمارات التعاقد مع المقاولين')),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 10.w,
              left: 10.w,
            ),
            child: ListView.builder(
              itemCount: contractList.length,
              itemBuilder: (BuildContext context, int index) {
                var date = contractList[index].date;
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
                                  'كود المقاول : ${contractList[index].code.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'حساب المتعاقد : ${contractList[index].userEmail.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'تاريخ الأشتراك: ${getDate(date!)}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'العنوان : ${contractList[index].address.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                                Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'الشغل المطلوب : ${contractList[index].description.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                                Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'تاريخ التسليم : ${contractList[index].deliveryDate.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
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
