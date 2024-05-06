import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/screens/dashboard/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'storage_info_card.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, child) {
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Total Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                provider.changeCategoryStatus();
              },
              child: Text(
                "category Add",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            provider.addCategory
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                        borderRadius: 5,
                        controller: _controller,
                        hintText: "Please add new category name",
                        fillColor: Colors.white.withOpacity(0.3)),
                  )
                : SizedBox.shrink(),
            provider.addCategory
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          provider.updateCategoryList(_controller.text, false, 0,false).then((value) {
                            _controller.clear();
                          });
                        },
                        child: Text(
                          "Save to Database",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                : SizedBox.shrink(),
            StreamBuilder<List<String>>(
                stream: provider.getCategoryListStream(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While the future is still loading, return a loading indicator or placeholder.
                          return SizedBox.shrink(); // Example loading indicator
                        } else if (snapshot.hasError) {
                          // If the future throws an error, display an error message.
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return StorageInfoCard(
                            title: "${snapshot.data![index]}",
                            index: index,
                          );
                        }
                      });
                })
          ],
        ),
      );
    });
  }
}
