import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/model%20copy/menu_model.dart';
import 'package:admin/model%20copy/user_model.dart';
import 'package:admin/screens/dashboard/components/custom_text.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
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
    // Provider.of<AdminProvider>(context, listen: false).getData();
    Provider.of<AdminProvider>(context, listen: false).getAllUserDetails();
    super.initState();
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
                          SideMenu(
                            builder: (data) => SideMenuData(
                              header: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text('Options'),
                              ),
                              items: [
                                SideMenuItemDataTile(
                                  isSelected: admin.menuSelectedIndex == 0
                                      ? true
                                      : false,
                                  onTap: () {
                                    admin.changeSelectedIndex(0);
                                    admin.menuSelectedIndex == 2
                                        ? admin.changeisNotice(false)
                                        : admin.changeisNotice(true);
                                  },
                                  title: '${admin.Sidebar[0]}',
                                  icon: const Icon(Icons.home),
                                ),
                                SideMenuItemDataTile(
                                  isSelected: admin.menuSelectedIndex == 1
                                      ? true
                                      : false,
                                  onTap: () {
                                    admin.changeSelectedIndex(1);
                                    admin.menuSelectedIndex == 2
                                        ? admin.changeisNotice(false)
                                        : admin.changeisNotice(true);
                                  },
                                  title: '${admin.Sidebar[1]}',
                                  icon: const Icon(Icons.post_add),
                                ),
                                SideMenuItemDataTile(
                                  isSelected: admin.menuSelectedIndex == 2
                                      ? true
                                      : false,
                                  onTap: () {
                                    admin.changeSelectedIndex(2);
                                    admin.menuSelectedIndex == 2
                                        ? admin.changeisNotice(false)
                                        : admin.changeisNotice(true);
                                  },
                                  title: '${admin.Sidebar[2]}',
                                  icon: const Icon(Icons.notification_add),
                                ),
                                SideMenuItemDataTile(
                                  isSelected: admin.menuSelectedIndex == 3
                                      ? true
                                      : false,
                                  onTap: () {
                                    admin.changeSelectedIndex(3);
                                    admin.menuSelectedIndex == 2
                                        ? admin.changeisNotice(false)
                                        : admin.changeisNotice(true);
                                  },
                                  title: '${admin.Sidebar[3]}',
                                  icon: const Icon(Icons.category),
                                ),
                                SideMenuItemDataTile(
                                  isSelected: admin.menuSelectedIndex == 4
                                      ? true
                                      : false,
                                  onTap: () {
                                    admin.changeSelectedIndex(4);
                                    admin.menuSelectedIndex == 2
                                        ? admin.changeisNotice(false)
                                        : admin.changeisNotice(true);
                                  },
                                  title: '${admin.Sidebar[4]}',
                                  icon: const Icon(Icons.view_sidebar),
                                ),
                                SideMenuItemDataTile(
                                  isSelected: admin.menuSelectedIndex == 5
                                      ? true
                                      : false,
                                  onTap: () {
                                    admin.changeSelectedIndex(5);
                                    admin.menuSelectedIndex == 2
                                        ? admin.changeisNotice(false)
                                        : admin.changeisNotice(true);
                                  },
                                  title: '${admin.Sidebar[5]}',
                                  icon: const Icon(Icons.view_agenda),
                                ),
                              ],
                            ),
                          ),
                          admin.menuSelectedIndex == 0
                              ? Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text(
                                                  "Total User: ${admin.users.length}"),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: admin.users.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  "User name : ${admin.users[index].userName}"),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                  "User email : ${admin.users[index].email}"),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                  "User ID : ${admin.users[index].userID}"),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      )
                                    ],
                                  ))
                              : admin.menuSelectedIndex == 1
                                  ? Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          SizedBox(height: defaultPadding),
                                          RecentFiles(),
                                        ],
                                      ),
                                    )
                                  : admin.menuSelectedIndex == 2
                                      ? Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              SizedBox(height: defaultPadding),
                                              RecentFiles(),
                                            ],
                                          ),
                                        )
                                      : admin.menuSelectedIndex == 3
                                          ? Expanded(
                                              flex: 4,
                                              child: CategoryDetails(),
                                            )
                                          : admin.menuSelectedIndex == 4
                                              ? Expanded(
                                                  flex: 4,
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
                                                  flex: 4, child: MyFiles()),
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