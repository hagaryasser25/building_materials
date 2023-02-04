import 'package:building_materials/models/cart_model.dart';
import 'package:building_materials/models/finishing_model.dart';
import 'package:building_materials/screens/admin/add_finishing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class UserCart extends StatefulWidget {
  static const routeName = '/userCart';
  const UserCart({super.key});

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Cart> cartList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCart();
  }

  @override
  void fetchCart() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("cart")
      .child(FirebaseAuth.instance.currentUser!.uid);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Cart p = Cart.fromJson(event.snapshot.value);
      cartList.add(p);
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
              backgroundColor: Colors.green, title: Text('سلة المشتريات')),
          body: Container(
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                  itemCount: cartList.length,
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
                                        '${cartList[index].name.toString()}',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'سعر الشيكارة : ${cartList[index].price.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: HexColor('#999999')),
                                      ),
                                      Text(
                                        'الكمية : ${cartList[index].amount.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: HexColor('#999999')),
                                      ),
                                      Text(
                                        'الأجمالى : ${cartList[index].total.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
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
                                              .child(
                                                  cartList[index].id.toString())
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
                                        '${cartList[index].imageUrl.toString()}')),
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
