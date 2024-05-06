import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/screens/dashboard/components/custom_text.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).addimageItem();
    super.initState();
  }

  String? selectedType;
  String? selectedSubType;
  TextEditingController jobName = TextEditingController();
  TextEditingController companyImage = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController jobDetails = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController notificationDescription = TextEditingController();
  TextEditingController applying = TextEditingController();
  Color textFieldColor = Color(0xff252329);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
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
              child:
                  Consumer<AdminProvider>(builder: (context, provider, child) {
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
                        maxLines: null,
                        borderRadius: 5,
                        inputType: TextInputType.multiline,
                        controller: description,
                        hintText: "Please enter JOB description",
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        inputType: TextInputType.multiline,
                        maxLines: null,
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
                        maxLines: null,
                        controller: companyImage,
                        hintText: "please add company image url",
                        borderRadius: 5,
                        fillColor: textFieldColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        maxLines: null,
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
                          return InkWell(
                            onTap: provider.changeSelectedCategory(snapshot.data![index]),
                            child: StorageInfoCard(
                              title: "${snapshot.data![index]}",
                              index: index,
                              isShowdot: false,
                            ),
                          );
                        }
                      });
                }),
         
              const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: textFieldColor,
                          borderRadius: BorderRadius.circular(5)),
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
                                          .copyWith(
                                              color:
                                                  Theme.of(context).hintColor),
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
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        child: ElevatedButton(
                      onPressed: () {
                        provider.deadlinePicker(context);
                      },
                      child: Text(
                          "Select deadline ${DateFormat('dd MMMM yyyy').format(provider.deadline)}"),
                    )),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: textFieldColor,
                          borderRadius: BorderRadius.circular(5)),
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
                                          .copyWith(
                                              color:
                                                  Theme.of(context).hintColor),
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
                            itemBuilder: (contex, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                    controller: provider.controller[index],
                                    hintText:
                                        "Please add image url number $index}",
                                    borderRadius: 5,
                                    fillColor: textFieldColor),
                              );
                            }),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          provider
                              .addNewJob(
                                  jobName: jobName.text,
                                  description: description.text,
                                  type: provider.jobSletedvalue ?? "",
                                  subtype: selectedType.toString(),
                                  jobDetails: jobDetails.text,
                                  salary: salary.text,
                                  companyImage: companyImage.text,
                                  link: applying.text)
                              .then((value) {
                            jobName.clear();
                            description.clear();
                            jobDetails.clear();
                            salary.clear();
                            companyImage.clear();
                            applying.clear();
                          });
                        },
                        child: Text("Add Post"),
                      ),
                    ),
                  ],
                );
              })),
        ],
      ),
    );
  }
}
