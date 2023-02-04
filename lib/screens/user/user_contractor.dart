import 'package:building_materials/models/contractors_model.dart';
import 'package:building_materials/screens/admin/add_contractor.dart';
import 'package:building_materials/screens/user/book_contractor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class UserContractor extends StatefulWidget {
  static const routeName = '/userContractor';
  const UserContractor({super.key});

  @override
  State<UserContractor> createState() => _UserContractorState();
}

class _UserContractorState extends State<UserContractor> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Contractors> contractorsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchContractors();
  }

  @override
  void fetchContractors() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("contractors");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Contractors p = Contractors.fromJson(event.snapshot.value);
      contractorsList.add(p);
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
            title: Text('التعاقد مع مقاول'),
          ),
          body: Container(
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 15.w,
                right: 15.w,
                bottom: 15.h,
              ),
              crossAxisCount: 6,
              itemCount: contractorsList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 10.w),
                      child: Column(children: [
                        SizedBox(height: 25.h),
                        Text(
                          '${contractorsList[index].code.toString()}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].name.toString()}'),
                        SizedBox(height: 5.h),
                        Text(
                            '${contractorsList[index].phoneNumber.toString()}'),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].company.toString()}'),
                        SizedBox(height: 5.h),
                        Text(
                            '${contractorsList[index].description.toString()}'),
                        SizedBox(height: 5.h),
                        Text(
                            '${contractorsList[index].email.toString()}'),
                        SizedBox(height: 5.h),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: 70.w, height: 35.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            child: Text('تعاقد'),
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BookContractor(
                                  code: contractorsList[index].code.toString(),
                                  email: contractorsList[index].email.toString(),
                                );
                              }));
                            },
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(3, index.isEven ? 3 : 3),
              mainAxisSpacing: 35.0,
              crossAxisSpacing: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
