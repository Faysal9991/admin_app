import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/model%20copy/job_model.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Jobs",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider,child) {
        return StreamBuilder<List<JobModel>>(
          stream: provider.getAllFood(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
      // While the future is still loading, return a loading indicator or placeholder.
      return SizedBox.shrink(); // Example loading indicator
    } else if (snapshot.hasError) {
      // If the future throws an error, display an error message.
      return Text('Error: ${snapshot.error}');
    } else {
      // If the future completes successfully, build your UI using the data.
      // Access the data from the cartDetails list here or perform any necessary actions.
        return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) => FileInfoCard(model: snapshot.data![index],index: index,provider: provider,),
            );
        // Replace YourWidget with your actual UI code
    }
           }
        );
      }
    );
  }
}
