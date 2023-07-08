import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:video_uploader/core/themes/colors.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/about_us_page.dart';
import 'package:video_uploader/presentation/pages/dialog.dart';

class HomePageForChar extends StatelessWidget {
  const HomePageForChar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  state is GetDataLoadingState
                      ? Center(
                          child: CircularProgressIndicator(
                            color: MyColors.lightGreen,
                          ),
                        )
                      : Container()
                ],
                title: Text(cubit.currentIndex == 0 ? "صورى" : "تعرف علينا"),
              ),
              body: cubit.currentIndex == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                        itemCount: cubit.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {},
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.image,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        cubit.images[index].path
                                            .split('/')
                                            .last,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton.icon(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      MyColors.lightGreen)),
                                          onPressed: () {
                                            cubit
                                                .uploadImageForChar(
                                                    index: index)
                                                .then((value) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          DialogBuild(
                                                            text: cubit.value[
                                                                    'result_alphabet']
                                                                .toString(),
                                                            state: state,
                                                          ));
                                            });
                                          },
                                          icon: const Icon(Icons.search),
                                          label: const Text("تنبأ"))
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    )
                  : const AboutUsPage(),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      label: "صورى", icon: Icon(Icons.image)),
                  BottomNavigationBarItem(
                      label: "تعرف علينا", icon: Icon(Icons.info)),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
              ),
              floatingActionButton: cubit.currentIndex == 0
                  ? SpeedDial(
                      backgroundColor: MyColors.lightGreen,
                      icon: Icons.add_a_photo,
                      activeIcon: Icons.close,
                      children: [
                        SpeedDialChild(
                            onTap: () {
                              cubit.getImageFromGallery();
                            },
                            backgroundColor: MyColors.lightGreen,
                            foregroundColor: Colors.white,
                            label: "من المعرض",
                            child: const Icon(Icons.photo)),
                        SpeedDialChild(
                            onTap: () {
                              cubit.getImageFromGallery();
                            },
                            backgroundColor: MyColors.lightGreen,
                            foregroundColor: Colors.white,
                            label: "التقط صورة",
                            child: const Icon(Icons.photo_camera))
                      ],
                    )
                  : null);
        },
      ),
    );
  }
}
