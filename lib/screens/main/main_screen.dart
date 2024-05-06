import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    var provider = Provider.of<AdminProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 300), () {
      provider.getData().then((value) => {
            provider.userLogin
                ? Navigator.pushReplacementNamed(context, '/menu')
                : Navigator.pushReplacementNamed(context, '/login')
          });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, chid) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Admin panel"),
        ),
        key: context.read<MenuAppController>().scaffoldKey,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen

              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: provider.userLogin ? LoginScreen() : DashboardScreen(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
