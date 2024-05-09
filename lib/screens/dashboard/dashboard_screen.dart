import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/model%20copy/menu_model.dart';
import 'package:admin/model%20copy/user_model.dart';
import 'package:admin/screens/dashboard/components/custom_text.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'components/recent_files.dart';
import 'components/category_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController menuName = TextEditingController();
  TextEditingController menuDetails = TextEditingController();
  TextEditingController updateMenuName = TextEditingController();
  TextEditingController UpdateMenuDetails = TextEditingController();
  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).getData();
    Provider.of<AdminProvider>(context, listen: false).getAllUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<AdminProvider>(context, listen: false).userController.onCancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color textFieldColor = Color(0xff252329);
    return Consumer<AdminProvider>(builder: (context, admin, child) {
      return admin.userLogin
          ? Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Admin panel"),
              ),
              body: SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: admin.Sidebar.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () {
                                        admin.changeSelectedIndex(index);
                                        admin.menuSelectedIndex == 2
                                            ? admin.changeisNotice(false)
                                            : admin.changeisNotice(true);
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                admin.menuSelectedIndex == index
                                                    ? Colors.white
                                                    : Colors.pinkAccent,
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                width: 1.0,
                                              ),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            "${admin.Sidebar[index]}",
                                            style: TextStyle(
                                                color:
                                                    admin.menuSelectedIndex ==
                                                            index
                                                        ? Colors.green
                                                        : Colors.white),
                                          )),
                                        ),
                                      ),
                                    );
                                  }))),
                          admin.menuSelectedIndex == 0
                              ? Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      StreamBuilder<List<UserModel>>(
                                          stream: admin.getAllUserDetails(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              // While the future is still loading, return a loading indicator or placeholder.
                                              return SizedBox
                                                  .shrink(); // Example loading indicator
                                            } else if (snapshot.hasError) {
                                              // If the future throws an error, display an error message.
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return Column(
                                                children: [
                                                  Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Text(
                                                          "Total User: ${snapshot.data!.length}"),
                                                    ),
                                                  ),
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          snapshot.data!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                          "User name : ${snapshot.data![index].userName}"),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                          "User email : ${snapshot.data![index].email}"),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                          "User ID : ${snapshot.data![index].userID}"),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              );
                                            }
                                          }),
                                    ],
                                  ))
                              : admin.menuSelectedIndex == 1
                                  ? Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          SizedBox(height: defaultPadding),
                                          RecentFiles(),
                                        ],
                                      ),
                                    )
                                  : admin.menuSelectedIndex == 2
                                      ? Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              SizedBox(height: defaultPadding),
                                              RecentFiles(),
                                            ],
                                          ),
                                        )
                                      : admin.menuSelectedIndex == 3
                                          ? Expanded(
                                              child: CategoryDetails(),
                                            )
                                          : admin.menuSelectedIndex == 4
                                              ? Expanded(
                                                  child:
                                                      Consumer<AdminProvider>(
                                                          builder: (context,
                                                              provider, child) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.blueGrey,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "Add Drawer Item"),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            CustomTextField(
                                                              controller:
                                                                  menuName,
                                                              maxLines: null,
                                                              borderRadius: 5,
                                                              inputType:
                                                                  TextInputType
                                                                      .multiline,
                                                              fillColor:
                                                                  textFieldColor,
                                                              hintText:
                                                                  "Item name",
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            CustomTextField(
                                                              controller:
                                                                  menuDetails,
                                                              maxLines: null,
                                                              borderRadius: 5,
                                                              inputType:
                                                                  TextInputType
                                                                      .multiline,
                                                              fillColor:
                                                                  textFieldColor,
                                                              hintText:
                                                                  "Discription",
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .green),
                                                                onPressed: () {
                                                                  if (menuName
                                                                      .text
                                                                      .isEmpty) {
                                                                    EasyLoading
                                                                        .showError(
                                                                            "please enter menu Name");
                                                                  } else if (menuDetails
                                                                      .text
                                                                      .isEmpty) {
                                                                    EasyLoading
                                                                        .showError(
                                                                            "please enter menu Details");
                                                                  } else {
                                                                    provider.addMenuItem(
                                                                        menuName
                                                                            .text,
                                                                        menuDetails
                                                                            .text);
                                                                  }
                                                                },
                                                                child: Text(
                                                                    "Save")),
                                                            StreamBuilder<
                                                                    List<
                                                                        MenuModel>>(
                                                                stream: provider
                                                                    .menuModel(),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    // While the future is still loading, return a loading indicator or placeholder.
                                                                    return SizedBox
                                                                        .shrink(); // Example loading indicator
                                                                  } else if (snapshot
                                                                      .hasError) {
                                                                    // If the future throws an error, display an error message.
                                                                    return Text(
                                                                        'Error: ${snapshot.error}');
                                                                  } else {
                                                                    // If the future completes successfully, build your UI using the data.
                                                                    // Access the data from the cartDetails list here or perform any necessary actions.
                                                                    return ListView.builder(
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.data!.length,
                                                                        itemBuilder: (context, index) => Center(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text('Edit Post'),
                                                                                        actions: [
                                                                                          Column(
                                                                                            children: [
                                                                                              CustomTextField(
                                                                                                maxLines: null,
                                                                                                borderRadius: 5,
                                                                                                inputType: TextInputType.multiline,
                                                                                                fillColor: textFieldColor,
                                                                                                hintText: "name",
                                                                                                controller: updateMenuName,
                                                                                              ),
                                                                                              CustomTextField(
                                                                                                maxLines: null,
                                                                                                borderRadius: 5,
                                                                                                inputType: TextInputType.multiline,
                                                                                                fillColor: textFieldColor,
                                                                                                hintText: "Discription",
                                                                                                controller: UpdateMenuDetails,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: double.infinity,
                                                                                                child: ElevatedButton(
                                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                                                    onPressed: () {
                                                                                                      admin.removeDrawerItem(snapshot.data![index].id!);
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      "Delete",
                                                                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                                                                                    )),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: double.infinity,
                                                                                                child: ElevatedButton(
                                                                                                    onPressed: () {
                                                                                                      admin.updateDrawerItem(snapshot.data![index].id!, updateMenuName.text, UpdateMenuDetails.text);
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                    child: Text("Update")),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: double.infinity,
                                                                                                child: ElevatedButton(
                                                                                                    onPressed: () {
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                    child: Text("close")),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Text("${snapshot.data![index].name}"),
                                                                              ),
                                                                            )));
                                                                    // Replace YourWidget with your actual UI code
                                                                  }
                                                                })
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                )
                                              : Expanded(
                                                  flex: 2, child: MyFiles()),
                        ])
                  ],
                ),
              ),
            )
          : ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text("Please login "));
    });
  }
}

 
                      

 
  // Divider(),
  //                