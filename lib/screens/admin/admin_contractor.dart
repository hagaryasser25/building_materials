import 'package:building_materials/models/contractors_model.dart';
import 'package:building_materials/screens/admin/add_contractor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class AdminContractor extends StatefulWidget {
  static const routeName = '/adminContractor';
  const AdminContractor({super.key});

  @override
  State<AdminContractor> createState() => _AdminContractorState();
}

class _AdminContractorState extends State<AdminContractor> {
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
            title: Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  // Your icon here
                  label: Text(
                    'أضافة مقاول',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Align(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )), // Your text here
                  onPressed: () {
                    Navigator.pushNamed(context, AddContractor.routeName);
                  },
                )),
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
                      padding:  EdgeInsets.only(
                        right: 10.w,
                        left: 10.w
                      ),
                      child: Column(children: [
                        SizedBox(height: 25.h),
                        Text(
                          '${contractorsList[index].code.toString()}',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].name.toString()}'),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].phoneNumber.toString()}'),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].company.toString()}'),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].description.toString()}'),
                        SizedBox(height: 5.h),
                        Text('${contractorsList[index].email.toString()}'),
                        SizedBox(height: 5.h),
                        InkWell(
                          onTap: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                            base
                                .child(contractorsList[index].id.toString())
                                .remove();
                          },
                          child: Icon(Icons.delete,
                              color: Color.fromARGB(255, 122, 122, 122)),
                        )
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
