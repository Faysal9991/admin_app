import 'package:admin/constants.dart';
import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/model%20copy/job_model.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditPost extends StatefulWidget {
  final JobModel model;
  const EditPost({Key? key, required this.model}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String? selectedType;
  String? selectedSubType;
  TextEditingController jobName = TextEditingController();
  TextEditingController companyImage = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController jobDetails = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController applying = TextEditingController();
  Color textFieldColor = Color(0xff252329);
  void initState() {
    var provider = Provider.of<AdminProvider>(context, listen: false);
    jobName.text = widget.model.name;
    companyImage.text = widget.model.companyImage;
    description.text = widget.model.description;
    jobDetails.text = widget.model.jobDetails;
    provider.selectedImageItem = widget.model.list.length;
    salary.text = widget.model.salary;
    applying.text = widget.model.link;
    provider.jobSletedvalue = widget.model.type;
    selectedSubType = widget.model.subtype;
    provider.changeImagelength(widget.model.list.length);
    for (int i = 0; i < provider.selectedImageItem; i++) {
      provider.controller[i].text = widget.model.list[i];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Control Job post",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: double.infinity,
              child: Consumer<AdminProvider>(builder: (context, provider, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: CustomTextField(
                              borderRadius: 5,
                              controller: jobName,
                              hintText: "Name",
                              fillColor: textFieldColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Do you want to Add This in popular"),
                        Expanded(
                          flex: 1,
                          child: Checkbox(
                              activeColor: Colors.green,
                              value: provider.isPopuer,
                              onChanged: (v) {
                                provider.changePopuler(v ?? false);
                              }),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        borderRadius: 5,
                        controller: description,
                        hintText: "Please enter JOB description",
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: jobDetails,
                        hintText: "please add JOB details",
                        borderRadius: 5,
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: salary,
                        hintText: "Enter job salary",
                        borderRadius: 5,
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: companyImage,
                        hintText: "please add company image url",
                        borderRadius: 5,
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: applying,
                        hintText: "Please add a link youse can Apply",
                        borderRadius: 5,
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<List<String>>(
                        stream: provider.getCategoryListStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While the future is still loading, return a loading indicator or placeholder.
                            return SizedBox.shrink(); // Example loading indicator
                          } else if (snapshot.hasError) {
                            // If the future throws an error, display an error message.
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                  color: textFieldColor, borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Please select a the job type',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Theme.of(context).hintColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  items: snapshot.data!
                                      .map((String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(color: Theme.of(context).hintColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: provider.jobSletedvalue,
                                  onChanged: (String? value) {
                                    provider.changejobcategory(value ?? "");
                                  },
                                ),
                              ),
                            );
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: textFieldColor, borderRadius: BorderRadius.circular(5)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Job subtype',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Theme.of(context).hintColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: provider.subType
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Theme.of(context).hintColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedSubType,
                          onChanged: (String? value) {
                            setState(() {
                              selectedSubType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: textFieldColor, borderRadius: BorderRadius.circular(5)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<int>(
                          isExpanded: true,
                          hint: Text(
                            'Please select a the job type',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Theme.of(context).hintColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: provider.imageItem
                              .map((int item) => DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Theme.of(context).hintColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: provider.selectedImageItem,
                          onChanged: (int? value) {
                            provider.changeImagelength(value ?? 0);
                          },
                        ),
                      ),
                    ),
                    provider.selectedImageItem == 0
                        ? SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: provider.selectedImageItem,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                    controller: provider.controller[index],
                                    hintText: "Please add image url number $index}",
                                    borderRadius: 5,
                                    fillColor: textFieldColor),
                              );
                            }),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        child: ElevatedButton(
                      onPressed: () {
                        provider.datePicker(context);
                      },
                      child: Text(
                          "Select sorting date ${DateFormat('dd MMMM yyyy').format(provider.selectedDate)}"),
                    )),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        provider.update(
                            jobName: jobName.text,
                            description: description.text,
                            type: provider.jobSletedvalue ?? "",
                            subtype: selectedSubType.toString(),
                            jobDetails: jobDetails.text,
                            salary: salary.text,
                            companyImage: companyImage.text,
                            link: applying.text,
                            id: widget.model.id,
                            date: provider.selectedDate);
                      },
                      child: Text("Update post"),
                    ),
                  ],
                );
              })),
        ],
      ),
    );
  }
}
