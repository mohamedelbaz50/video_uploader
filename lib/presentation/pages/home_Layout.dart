import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

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
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            drawer: cubit.currentIndex == 0
                ? Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const DrawerHeader(
                            child: Icon(
                          Icons.settings,
                          size: 70,
                          color: Colors.grey,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    cubit.changTheme();
                                  },
                                  child: Icon(
                                    Icons.brightness_4_outlined,
                                    color: Theme.of(context).focusColor,
                                  )),
                              const Spacer(),
                              Text(
                                ".. تغيير الوضع",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.language,
                                color: Theme.of(context).focusColor,
                              ),
                              const Spacer(),
                              Text(
                                " .. تغيير اللغه",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
            body: cubit.bottomNavPages[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    label: " ترجمه", icon: Icon(Icons.type_specimen)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.repeat), label: "ترجمه عكسيه"),
                BottomNavigationBarItem(
                    label: "تعلم", icon: Icon(Icons.school)),
                BottomNavigationBarItem(
                    label: "تعرف علينا", icon: Icon(Icons.info)),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
          );
        },
      ),
    );
  }
}
