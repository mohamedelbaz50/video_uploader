import 'package:flutter/material.dart';
import 'package:video_uploader/presentation/pages/home_page_for_char.dart';
import 'package:video_uploader/presentation/pages/home_page_for_number.dart';
import 'package:video_uploader/presentation/pages/home_page_for_words.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              Text(
                ": عن ماذا تريد التنبؤ ",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              buildItem(
                  context: context,
                  text: "رقم",
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePageForNumbers()));
                  }),
              buildItem(
                  context: context,
                  text: "حرف",
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePageForChar()));
                  }),
              buildItem(
                  context: context,
                  text: "كلمه",
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageForWords()));
                  })
            ],
          ),
        ),
      ),
    );
  }

  buildItem(
      {required BuildContext context,
      required String text,
      required Function ontap}) {
    return Center(
      child: InkWell(
        onTap: () {
          ontap();
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height / 7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(5, 1), blurRadius: 1, color: Colors.grey)
              ]),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
