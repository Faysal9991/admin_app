import 'package:admin/model%20copy/job_model.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/edit_post.dart';
import 'package:admin/screens/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginScreen(),
  '/': (context) => MainScreen(),
  '/menu': (context) => DashboardScreen(),
  '/all_job': (context) => MyFiles(),
  '/editPost': (context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final jobModel = arguments as JobModel;
    return EditPost(model: jobModel);
  },
  // Add more routes as needed
};
