import 'package:flutter/material.dart';
import 'package:video_uploader/core/themes/colors.dart';
import 'package:video_uploader/presentation/pages/data.dart';
import 'package:video_uploader/presentation/pages/exam_page.dart';
import 'package:video_uploader/presentation/pages/show_learn_video.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return buildLearnItem(
                    context: context, data: data, index: index, labels: labels);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: 10)),
    );
  }

  buildLearnItem(
      {required BuildContext context,
      required Map<String, dynamic> data,
      required List labels,
      required int index}) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 10,
      decoration: BoxDecoration(
          boxShadow: [],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(labels[index], style: TextStyle(color: Colors.black)),
          Spacer(),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.lightPurple),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExamPage(label: labels[index])));
              },
              icon: Icon(Icons.create),
              label: Text("اختبر نفسك")),
          SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.lightPurple),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowLearnVideo(word: labels[index])));
              },
              icon: Icon(Icons.menu_book),
              label: Text(" تعلمها"))
        ],
      ),
    );
  }
}
