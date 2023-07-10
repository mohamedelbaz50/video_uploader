import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_uploader/core/themes/colors.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/choose_page.dart';
import 'package:video_uploader/presentation/pages/home_page_for_words.dart';
import 'package:video_uploader/presentation/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                      width: width,
                      height: height,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 14, vertical: height / 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/login.jpg"))),
                            ),
                            Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                  color: MyColors.lightPurple,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                                label: "البريد الالكترونى",
                                hintText: "أدخل البريد الالكترونى",
                                controller: emailController,
                                textInputType: TextInputType.emailAddress),
                            CustomTextFormField(
                                label: "كلمة السر",
                                hintText: "أدخل كلمة السر",
                                controller: passwordController,
                                textInputType: TextInputType.visiblePassword),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "نسيت كلمة السر؟",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: MyColors.lightPurple),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text("أنشىء حساب",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: MyColors.lightPurple)),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Text(
                                  "لا تمتلك حساب؟",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChoosePage()));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: MyColors.lightPurple,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                    child: Text(
                                  "ادخل كضيف",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          ],
                        ),
                      ))
                ]))));
      },
    );
  }
}
