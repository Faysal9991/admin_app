import 'package:admin/controllers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatefulWidget {
  const StorageInfoCard({Key? key, required this.title, required this.index,this.isShowdot=true})
      : super(key: key);

  final String title;
  final int index;
  final bool? isShowdot;

  @override
  State<StorageInfoCard> createState() => _StorageInfoCardState();
}

class _StorageInfoCardState extends State<StorageInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
         Visibility(
          visible: widget.isShowdot!,
           child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Edit Post'),
                          actions: [
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        provider
                                            .updateCategoryList(
                                                "", true, widget.index, false)
                                            .then((value) =>
                                                Navigator.of(context).pop());
                                      },
                                      child: Text(
                                        "Delete",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
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
                  icon: Icon(Icons.more_vert)),
         )
          ],
        ),
      );
    });
  }
}
