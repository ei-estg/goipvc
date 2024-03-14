import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/widgets/catchphrase.dart';
import 'package:goipvc/ui/widgets/current_date.dart';
import 'package:goipvc/ui/widgets/home_view_tabs.dart';
import 'package:goipvc/ui/widgets/profile_picture.dart';

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
      ? Builder(
          builder: (context) {
            if(MediaQuery.of(context).orientation == Orientation.portrait){
              return Center(
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
                                Text(
                                  "Olá ${profile.nome.split(" ")[0]}!",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const CatchPhrase()
                              ],
                            ),
                            CurrentDate()
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
                          child: HomeViewTabs(tabController: _tabController)
                      )
                    ],
                  )
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfilePicture(
                          imageData: profile.fotografia,
                          size: MediaQuery.of(context).size.width/10,
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                        const CatchPhrase(),
                        Text(
                          "Olá ${profile.nome.split(" ")[0]}!",
                          style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                        SvgPicture.asset(
                          'assets/ipvc-divider.svg',
                          width: MediaQuery.of(context).size.width / 6,
                        ),
                      ]
                    )
                  ),
                  Expanded(
                    flex: 3,
                    child: HomeViewTabs(tabController: _tabController)
                  )
                ],
              );
            }
          }
      )
      : const ErrorView(error: "Erro a obter perfil");
      },
    );
  }
}