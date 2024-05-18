import 'dart:async';

import 'package:admin/model%20copy/job_model.dart';
import 'package:admin/model%20copy/menu_model.dart';
import 'package:admin/model%20copy/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool userLogin = false;
  saveData(bool value) async {
    final SharedPreferences save = await SharedPreferences.getInstance();
    userLogin = value;
    save.setBool("userLogin", userLogin);
    notifyListeners();
  }

  Future<bool> getData() async {
    final SharedPreferences save = await SharedPreferences.getInstance();
    return userLogin = save.getBool("userLogin") ?? false;
  }

  Future init() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // get the device fcm token
    final token = await firebaseMessaging.getToken();
    print("device token: $token");
  }

  int selectedImageItem = 0;
  List<TextEditingController> controller = [];
  final List<int> imageItem = [];
  addimageItem() {
    for (int i = 0; i < 40; i++) {
      imageItem.add(i);
      controller.add(TextEditingController());
    }
  }

  changeImagelength(int value) {
    selectedImageItem = value;
    notifyListeners();
  }

  bool isPopuer = false;
  changePopuler(bool value) {
    isPopuer = value;
    notifyListeners();
  }

  final List<String> subType = [
    'Full time',
    'Part time',
    'Any Where',
  ];
  bool isLoading = false;

  List imageList = [];
  String companyPicture = "";
  final CollectionReference _jobdata =
      FirebaseFirestore.instance.collection('jobFields');
  final CollectionReference menuName =
      FirebaseFirestore.instance.collection('menu');
  Stream<List<MenuModel>> menuModel() {
    return menuName.snapshots().map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((QueryDocumentSnapshot documentSnapshot) {
        return MenuModel(
          name: documentSnapshot.get('name') ?? "",
          details: documentSnapshot.get('details') ?? "",
          id: documentSnapshot.id,
        );
      }).toList();
    });
  }

  Stream<List<JobModel>> getAllFood() {
    return _jobdata.snapshots().map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((QueryDocumentSnapshot documentSnapshot) {
        return JobModel(
            name: documentSnapshot.get('name') ?? "",
            description: documentSnapshot.get('description') ?? "",
            id: documentSnapshot.id,
            type: documentSnapshot.get('type') ?? "",
            jobDetails: documentSnapshot.get('jobDetails') ?? "",
            companyImage: documentSnapshot.get('companyImage') ?? "",
            list: documentSnapshot.get('list') ?? [],
            link: documentSnapshot.get('link') ?? "",
            popular: documentSnapshot.get('popular') ?? "",
            date: documentSnapshot.get('date') ?? "",
            deadline: documentSnapshot.get('deadline') ?? "",
            bookMark: documentSnapshot.get('bookMark') ?? [],
            battonName: documentSnapshot.get("batunName") ?? "");
      }).toList();
    });
  }

  bool isNotice = false;
  changeisNotice(bool value) {
    isNotice = value;
    notifyListeners();
  }

  DateTime? publisDate;

  purplishDatePicker(BuildContext context) async {
    DateTime? newDateTime = await showDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2200),
      context: context,
    );
    publisDate = newDateTime ?? DateTime.now();
    notifyListeners();
  }

  Future<bool> addNewJob({
    required String jobName,
    required String description,
    required String type,
    required String subtype,
    required String jobDetails,
    required String companyImage,
    required String link,
    required String batunName,
    bool? isNotice = false,
  }) async {
    List image = [];
    for (int i = 0; i < selectedImageItem; i++) {
      image.add(controller[i].text);
    }
    // Obtain shared preferences.
    EasyLoading.show(status: "Creating new Job");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      firestore.collection("jobFields").add({
        "name": jobName,
        "description": description,
        "type": type,
        "subtype": subtype,
        "jobDetails": jobDetails,
        "companyImage": companyImage,
        "list": image,
        "link": link,
        "bookMark": [],
        "date": selectedDate,
        "deadline": deadline,
        "popular": isPopuer,
        "publishDate": publisDate,
        "batunName": batunName,
      }).then((value) {
        print("-------${value.id}");
      });
      EasyLoading.showSuccess("Successful");
      controller.clear();
      selectedImageItem = 0;
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> sendNotificationLocal({
    required String title,
    required String description,
  }) async {
    // Obtain shared preferences.
    EasyLoading.show(status: "Creating new notification");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      firestore
          .collection("notification")
          .add({"title": title, "description": description, "user": []}).then(
              (value) {});
      EasyLoading.showSuccess("Successful");
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  removeJob(String id) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("jobFields").doc(id).delete();
  }

  String? jobSletedvalue;
  changejobcategory(String value) {
    jobSletedvalue = value;
    notifyListeners();
  }

  DateTime? selectedDate;

  datePicker(BuildContext context) async {
    DateTime? newDateTime = await showDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      context: context,
    );
    selectedDate = newDateTime ?? DateTime.now();
    notifyListeners();
  }

  DateTime? deadline;

  deadlinePicker(BuildContext context) async {
    DateTime? newDateTime = await showDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2200),
      context: context,
    );
    deadline = newDateTime ?? DateTime.now();
    notifyListeners();
  }

  update({
    required String jobName,
    required String description,
    required String type,
    required String jobDetails,
    required String companyImage,
    required DateTime date,
    required String link,
    required String id,
  }) {
    EasyLoading.show(status: 'loading...');
    List image = [];
    for (int i = 0; i < selectedImageItem; i++) {
      image.add(controller[i].text);
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("jobFields").doc(id).update({
      "name": jobName,
      "description": description,
      "type": type,
      "jobDetails": jobDetails,
      "companyImage": companyImage,
      "list": image,
      "link": link,
      "bookMark": [],
      "popular": isPopuer,
      "date": selectedDate,
      "deadline": deadline,
    });

    EasyLoading.showSuccess('Great Success!');
    controller.clear();
    selectedImageItem = 0;
    notifyListeners();
  }

  bool addCategory = false;
  changeCategoryStatus() {
    addCategory = !addCategory;
    notifyListeners();
  }

  bool CategoryController = false;
  changeCategoryController() {
    CategoryController = !CategoryController;
    notifyListeners();
  }

  String? selectedCategory;
  changeSelectedCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  String? selectedSubType;
  changeSubtype(String value) {
    selectedSubType = value;
    notifyListeners();
  }

  List<String> jobList = [];

  Stream<List<String>> getCategoryListStream() {
    // Get the document reference
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('category')
        .doc('EEJyW5MD5xIECYYEEkFH');

    // Return a stream that listens to changes on the document reference
    return documentReference
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      // Check if the document exists and contains the jobCategory field
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        // Get the list of strings from the jobCategory field
        List<String>? jobCategoryList =
            List<String>.from(documentSnapshot.get('jobCategory'));
        jobList = jobCategoryList;
        return jobCategoryList;
      } else {
        // Document doesn't exist or jobCategory field is empty
        return [];
      }
    });
  }

  Future<void> updateCategoryList(
      String newJob, bool isRemove, int index, bool isUpdate) async {
    if (isRemove) {
      jobList.removeAt(index);
    } else {
      jobList.add(newJob);
    }

    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('category')
          .doc('EEJyW5MD5xIECYYEEkFH');
      await documentReference.update({'jobCategory': jobList});
      EasyLoading.showSuccess("New category added");
    } catch (e) {
      print('Error updating category list: $e');
    }
  }

  removeDrawerItem(String id) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("menu").doc(id).delete();
  }

  Future<void> updateDrawerItem(String id, String name, String details) async {
    if (name.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('menu')
          .doc(id)
          .update({"name": name});
    }

    if (details.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('menu')
          .doc(id)
          .update({"details": details});
    }
  }

  addMenuItem(String name, String details) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      firestore.collection("menu").add({"name": name, "details": details});
    } catch (e) {
      EasyLoading.showError("e");
    }
    EasyLoading.showSuccess("added");
    notifyListeners();
  }

  int menuSelectedIndex = 0;
  changeSelectedIndex(int index) {
    menuSelectedIndex = index;
    notifyListeners();
  }

  List<UserModel> users = [];
  getAllUserDetails() async {
    EasyLoading.showInfo('Loading!');
    users.clear();
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        UserModel user = UserModel(
          userName: doc["userName"],
          email: doc["email"],
          userID: doc.id,
        );

        users.add(user);
      }
    } catch (e) {
      EasyLoading.showError("${e}");
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  List<String> Sidebar = [
    "DashBoard",
    "Post Job",
    "Notice post",
    "post category",
    "Post sidebar",
    "view JobS"
  ];
}
