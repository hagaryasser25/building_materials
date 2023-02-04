import 'package:building_materials/models/finishing_model.dart';
import 'package:building_materials/screens/admin/add_building.dart';
import 'package:building_materials/screens/admin/add_finishing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminBuilding extends StatefulWidget {
  static const routeName = '/adminBuilding';
  const AdminBuilding({super.key});

  @override
  State<AdminBuilding> createState() => _AdminBuildingState();
}

class _AdminBuildingState extends State<AdminBuilding> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<FinishingMaterials> materialsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMaterials();
  }

  @override
  void fetchMaterials() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("BuildingMaterials");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      FinishingMaterials p = FinishingMaterials.fromJson(event.snapshot.value);
      materialsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  // Your icon here
                  label: Text(
                    'أضافة مواد بناء',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Align(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )), // Your text here
                  onPressed: () {
                    Navigator.pushNamed(context, AddBuilding.routeName);
                  },
                )),
          ),
          body: Container(
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                  itemCount: materialsList.length,
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
                                  top: 10, left: 15, bottom: 10),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${materialsList[index].name.toString()}',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'سعر الشيكارة : ${materialsList[index].price.toString()}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor('#999999')),
                                      ),
                                      Text(
                                        'الشركة المصنعة : ${materialsList[index].company.toString()}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor('#999999')),
                                      ),
                                      Text(
                                        'الكمية المتاحة : ${materialsList[index].amount.toString()}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor('#999999')),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget));
                                          base
                                              .child(materialsList[index]
                                                  .id
                                                  .toString())
                                              .remove();
                                        },
                                        child: Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 122, 122, 122)),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 110.w,
                                    height: 170.h,
                                    child: Image.network(
                                        '${materialsList[index].imageUrl.toString()}')),
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
