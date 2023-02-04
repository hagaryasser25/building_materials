import 'package:building_materials/models/finishing_model.dart';
import 'package:building_materials/screens/admin/add_finishing.dart';
import 'package:building_materials/screens/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class UserFinishing extends StatefulWidget {
  static const routeName = '/userFinishing';
  const UserFinishing({super.key});

  @override
  State<UserFinishing> createState() => _UserFinishingState();
}

class _UserFinishingState extends State<UserFinishing> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<FinishingMaterials> materialsList = [];
  List<String> keyslist = [];
  var amountController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMaterials();
  }

  @override
  void fetchMaterials() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("finishingMaterials");
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
              backgroundColor: Colors.green, title: Text('مواد التشطيبات')),
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
                                  top: 10, right: 15, left: 15, bottom: 10),
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
                                            fontSize: 17,
                                            color: HexColor('#999999')),
                                      ),
                                      Text(
                                        'الشركة المصنعة : ${materialsList[index].company.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: HexColor('#999999')),
                                      ),
                                      Text(
                                        'الكمية المتاحة : ${materialsList[index].amount.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: HexColor('#999999')),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              width: 100.0,
                                              height: 50.h,
                                              child: TextField(
                                                controller: amountController,
                                                textAlign: TextAlign.center,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  fillColor:
                                                      HexColor('#155564'),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2.0),
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  hintText: 'ادخل الكمية',
                                                ),
                                              )),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              String name = materialsList[index]
                                                  .name
                                                  .toString();
                                              int? price =
                                                  materialsList[index].price;
                                              int amount = int.parse(
                                                  amountController.text.trim());
                                              int total = price! * amount;
                                              String imageUrl = materialsList[index]
                                                  .imageUrl
                                                  .toString();

                                              if (amount == 0) {
                                                Fluttertoast.showToast(
                                                    msg: 'ادخل الكمية');
                                                return;
                                              }

                                              User? user = FirebaseAuth
                                                  .instance.currentUser;

                                              if (user != null) {
                                                String uid = user.uid;

                                                DatabaseReference companyRef =
                                                    FirebaseDatabase.instance
                                                        .reference()
                                                        .child('cart').child(uid);

                                                String? id =
                                                    companyRef.push().key;

                                                await companyRef
                                                    .child(id!)
                                                    .set({
                                                  'id': id,
                                                  'name': name,
                                                  'price': price,
                                                  'amount': amount,
                                                  'total': total,
                                                  'imageUrl': imageUrl
                                                });
                                              }

                                              showAlertDialog(context);
                                            },
                                            child: Icon(Icons.shopping_cart,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          ),
                                        ],
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
void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم الأضافة فى سلة المشتريات"),
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
