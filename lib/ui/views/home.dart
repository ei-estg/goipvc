import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/ui/views/coming_soon.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/widgets/profile_picture.dart';

import '../widgets/schedule_tab.dart';

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
    _tabController = TabController(length: 2, vsync: this);
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
                flex: 1,
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                      child: Text("Hoje", style: TextStyle(fontSize: 20))
                    ),
                    TabBar(
                      controller: _tabController,
                      tabs: const <Tab>[
                        Tab(
                          text: "Horários",
                          icon: Icon(Icons.schedule),
                        ),
                        Tab(
                          text: "Ementas",
                          icon: Icon(Icons.restaurant_menu),
                        )
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(16.0),
                            child: TabBarView(
                            controller: _tabController,
                            children: const <Widget>[
                              ScheduleTab(),
                              ComingSoonView()
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