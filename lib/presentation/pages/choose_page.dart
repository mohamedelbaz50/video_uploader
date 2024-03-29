import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_uploader/core/themes/colors.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/home_page_for_char.dart';
import 'package:video_uploader/presentation/pages/home_page_for_number.dart';
import 'package:video_uploader/presentation/pages/home_page_for_words.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    Text(": ماذا تريد أن تترجم ",
                        style: Theme.of(context).textTheme.bodyMedium),
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
                                  builder: (context) =>
                                      const HomePageForNumbers()));
                        }),
                    buildItem(
                        context: context,
                        text: "حرف",
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePageForChar()));
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
        },
      ),
    );
  }

  buildItem(
      {required BuildContext context,
      required String text,
      required Function ontap}) {
    return Center(
      child: GestureDetector(
        onTap: () {
          ontap();
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height / 7,
          decoration: BoxDecoration(
              color: MyColors.lightPurple,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(5, 1), blurRadius: 2, color: Colors.black)
              ]),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
