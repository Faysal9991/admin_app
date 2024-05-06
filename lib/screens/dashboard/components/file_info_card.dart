import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/model%20copy/job_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.index,
    required this.model,
    required this.provider
  }) : super(key: key);

  final int index;
  final JobModel model;
  final AdminProvider provider;

  @override
  Widget build(BuildContext context) {
  
    return InkWell(
         onTap: (){showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit Post'),
                 
                    actions: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: (){
    provider.removeJob(model.id);
      }, child: Text("Delete the post",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),
    ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: (){
    Navigator.pushNamed(context, '/editPost', arguments: model);
      }, child: Text("Edit  the post",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),
    
      ElevatedButton(
    
      onPressed: (){Navigator.of(context).pop();}, child: Text("close")),
                  ],
                  );
                },
              );
                },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.network(
                    model.companyImage,
                    fit: BoxFit.cover,
                  ),
                ),
               Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
               
              ],
            ),
             Text(
              "Job id = ${model.id}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
             Text(
            "Deadline = ${ DateFormat('dd-mm-yyyy').format(model.deadline.toDate())}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.amber),
            ),
             Text(
             ' job descreption ${ model.description}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.green),
            ),
           
             Text(
              model.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
