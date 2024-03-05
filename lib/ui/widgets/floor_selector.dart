import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/info.dart';
import 'package:photo_view/photo_view.dart';
import 'package:goipvc/ui/floors.dart';

class FloorSelector extends StatefulWidget {
  final MyIPVCUser? profile;
  final String theme;

  FloorSelector({required this.profile, required this.theme});

  @override
  _FloorSelectorState createState() => _FloorSelectorState();
}

class _FloorSelectorState extends State<FloorSelector> {
  var currentFloor = 0;

  void _openImage(BuildContext context, String img) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar:
                  AppBar(title: const Text("A visualizar planta da escola")),
              body: Hero(
                tag: img,
                child: PhotoView(
                  imageProvider: AssetImage(img),
                  backgroundDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PISO ${currentFloor + 1}",
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          GestureDetector(
              onTap: () {
                _openImage(
                    context,
                    schoolMaps[widget.profile?.unidadeOrganica]![currentFloor]
                        [widget.theme]);
              },
              child: Hero(
                tag: schoolMaps[widget.profile?.unidadeOrganica]![currentFloor]
                    [widget.theme],
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    schoolMaps[widget.profile?.unidadeOrganica]![currentFloor]
                        [widget.theme],
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   color: Theme.of(context).colorScheme.primary,
              //   onPressed: () {
              //     setState(() {
              //       if (currentFloor > 0) {
              //         currentFloor--;
              //       }
              //     });
              //   },
              // ),
              // IconButton(
              //   icon: const Icon(Icons.arrow_forward),
              //   color: Theme.of(context).colorScheme.primary,
              //   onPressed: () {
              //     setState(() {
              //       if (currentFloor <
              //           schoolMaps[widget.profile?.unidadeOrganica]!.length -
              //               1) {
              //         currentFloor++;
              //       }
              //     });
              //   },
              // ),

              SegmentedButton<int>(
                segments: <ButtonSegment<int>>[
                  for (int i = 0;
                      i < schoolMaps[widget.profile?.unidadeOrganica]!.length;
                      i++)
                    ButtonSegment<int>(
                      value: i + 1,
                      label: Text("Piso ${i + 1}"),
                    ),
                ],
                selected: <int>{currentFloor + 1},
                selectedIcon: const Icon(
                  Icons.map,
                  color: Colors.black,
                ),
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    currentFloor = newSelection.first - 1;
                  });
                },
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Legenda",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.theme == "dark"
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var caption in schoolMaps[widget
                          .profile?.unidadeOrganica]![currentFloor]["caption"])
                        Row(
                          children: [
                            Text(
                              caption,
                              style: TextStyle(
                                fontSize: 16,
                                color: (widget.theme == "dark"
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
