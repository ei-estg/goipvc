import 'package:flutter/material.dart';
import 'package:goipvc/models/myipvc/user.dart';
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
          appBar: AppBar(title: const Text("A visualizar planta da escola")),
          body: Hero(
            tag: img,
            child: PhotoView(
              imageProvider: AssetImage(img),
              backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface
              ),
            ),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _openImage(context, schoolMaps[widget.profile?.unidadeOrganica]![currentFloor][widget.theme]);
          },
          child: Hero(
              tag: schoolMaps[widget.profile?.unidadeOrganica]![currentFloor][widget.theme],
              child: Image.asset(schoolMaps[widget.profile?.unidadeOrganica]![currentFloor][widget.theme])
          ),
        ),
        
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var i = 0; i < schoolMaps[widget.profile?.unidadeOrganica]!.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentFloor = i;
                      });
                    },
                    child: Text("Piso ${i + 1}"),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}