import 'package:building_materials/screens/admin/add_building.dart';
import 'package:building_materials/screens/admin/add_contractor.dart';
import 'package:building_materials/screens/admin/add_finishing.dart';
import 'package:building_materials/screens/admin/admin_building.dart';
import 'package:building_materials/screens/admin/admin_complains.dart';
import 'package:building_materials/screens/admin/admin_contractor.dart';
import 'package:building_materials/screens/admin/admin_finishing.dart';
import 'package:building_materials/screens/admin/admin_home.dart';
import 'package:building_materials/screens/admin/contract_list.dart';
import 'package:building_materials/screens/auth/admin_login.dart';
import 'package:building_materials/screens/auth/login.dart';
import 'package:building_materials/screens/auth/signUp.dart';
import 'package:building_materials/screens/user/book_contractor.dart';
import 'package:building_materials/screens/user/send_complain.dart';
import 'package:building_materials/screens/user/user_building.dart';
import 'package:building_materials/screens/user/user_cart.dart';
import 'package:building_materials/screens/user/user_complain.dart';
import 'package:building_materials/screens/user/user_contractor.dart';
import 'package:building_materials/screens/user/user_finishing.dart';
import 'package:building_materials/screens/user/user_home.dart';
import 'package:building_materials/screens/user/user_replays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : UserHome(email: FirebaseAuth.instance.currentUser!.email!,
              name: FirebaseAuth.instance.currentUser!.displayName!,),
      routes: {
          SignUpPage.routeName: (ctx) => SignUpPage(),
          UserHome.routeName: (ctx) => UserHome(email: FirebaseAuth.instance.currentUser!.email!,
          name: FirebaseAuth.instance.currentUser!.displayName!),
          LoginPage.routeName: (ctx) => LoginPage(),
          AdminLogin.routeName: (ctx) => AdminLogin(),
          AdminFinishing.routeName: (ctx) => AdminFinishing(),
          AddFinishing.routeName: (ctx) => AddFinishing(),
          AdminHome.routeName: (ctx) => AdminHome(),
          AdminBuilding.routeName: (ctx) => AdminBuilding(),
          AddBuilding.routeName: (ctx) => AddBuilding(),
          UserFinishing.routeName: (ctx) => UserFinishing(),
          UserBuilding.routeName: (ctx) => UserBuilding(),
          AdminContractor.routeName: (ctx) => AdminContractor(),
          AddContractor.routeName: (ctx) => AddContractor(),
          UserContractor.routeName: (ctx) => UserContractor(),
          ContractList.routeName: (ctx) => ContractList(),
          UserComplain.routeName: (ctx) => UserComplain(),
          SendComplain.routeName: (ctx) => SendComplain(),
          AdminComplains.routeName: (ctx) => AdminComplains(),
          UserReplays.routeName: (ctx) => UserReplays(),
          UserCart.routeName: (ctx) => UserCart(),
      },
    );
  }
}

