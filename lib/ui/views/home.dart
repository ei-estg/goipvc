import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/providers/schedule_provider.dart';
import 'package:myipvc_budget_flutter/services/date_verification.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';
import 'package:myipvc_budget_flutter/ui/widgets/lesson_card.dart';
import 'package:myipvc_budget_flutter/ui/widgets/profile_picture.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        MyIPVCUser? profile = ref.watch(profileProvider);
        AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);

        return profile != null
        ? Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: 'O ',
                                ),
                                TextSpan(
                                  text: 'teu',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    fontSize: 80,
                                    height: 0.1
                                  ),
                                ),
                                TextSpan(
                                  text: 'de partida',
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Olá ${profile.nome.split(" ")[0]}!",
                            style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      ProfilePicture(
                        imageData: profile.fotografia,
                        size: 100,
                      ),
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child:
                          SvgPicture.asset(
                            'assets/ipvc-divider.svg',
                            width: 1000,
                          ),
                      ),
                    ]
                  )
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          tabs: const <Tab>[
                            Tab(
                              text: "Horarios",
                              icon: Icon(Icons.schedule), // Icon for Horarios
                            ),
                            Tab(
                              text: "Ementas",
                              icon: Icon(Icons.restaurant_menu), // Icon for Ementas
                            ),
                            Tab(
                              text: "Exames",
                              icon: Icon(Icons.assignment), // Icon for Exames
                            ),
                          ],
                        ),
                        Expanded(
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.all(16.0),
                                child: TabBarView(
                                  controller: _tabController,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: schedule.when(
                                          loading: () => const LoadingView(),
                                          error: (err, stack) => ErrorView(error: "$err"),
                                          data: (schedule) {
                                            schedule.removeWhere((lesson) =>
                                                verifyIfLessonExpired(lesson));

                                            if(schedule.isEmpty){
                                              return const Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [Text("Não existem aulas hoje")],
                                                ),
                                              );
                                            }

                                            return Column(
                                              children: [
                                                const ListTile(
                                                  title: Text(
                                                      'Hoje:',
                                                      style: TextStyle(fontSize: 20)
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView(
                                                    children: [
                                                      for(var lesson in schedule)
                                                        LessonCard(lesson: lesson)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text("Não Existe Ementas Hoje"),
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text("Não Existe Exames Hoje"),
                                    ),
                                  ],
                                )

                              )
                          )
                      ],
                    )
                )
              ],
            )
          )
        : const ErrorView(error: "Erro a obter perfil");
      },
    );
  }
}