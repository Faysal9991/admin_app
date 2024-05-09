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
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                 height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.network(
                    model.companyImage,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10,),
            Text( "Title : ${model.name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10,),
             Text(
              "Job Id : ${model.id}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10,),
             Text(
            "Deadline : ${ DateFormat('dd-mm-yyyy').format(model.deadline.toDate())}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
             
            ),
            SizedBox(height: 10,),
             Column(
               children: [
                 Text(
                 'Description:\n ${ model.description}',
                  maxLines: null,
                  ),
               ],
             ),
           SizedBox(height: 10,),
             Text(
              "Type: ${model.type}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
             
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
