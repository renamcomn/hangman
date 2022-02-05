import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/ui/colors.dart';
import 'package:movies/ui/widget/figure_image.dart';
import 'package:movies/ui/widget/letter.dart';
import 'package:movies/utils/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp()
    );
  }
}

class HomeApp extends StatefulWidget {

  const HomeApp({ Key? key }) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  String word = "";

  List<String> words = [
    "flutter",
    "brutkasten",
    "developer",
    "fullstack",
    "corinthians",
    "react",
    "nodejs",
    "acidmud"
  ];

  List<String> alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  String changeWord() {
    var numeroSorteado = Random().nextInt(words.length);
    word = words[numeroSorteado];
    return word.toString().toUpperCase();
  }

  @override
  void initState() {
    changeWord();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
          backgroundColor: AppColor.PrimaryColor,
          appBar: AppBar(title: const Text('Hangman'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColor.PrimaryColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    figureImage(Game.tries >= 0, "assets/hang.png"),
                    figureImage(Game.tries >= 1, "assets/head.png"),
                    figureImage(Game.tries >= 2, "assets/body.png"),
                    figureImage(Game.tries >= 3, "assets/ra.png"),
                    figureImage(Game.tries >= 4, "assets/la.png"),
                    figureImage(Game.tries >= 5, "assets/rl.png"),
                    figureImage(Game.tries >= 6, "assets/ll.png"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: word.split("").map((e) => letter(e.toUpperCase(), !Game.selectedChar.contains(e.toUpperCase()))).toList(),
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: GridView.count(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: EdgeInsets.all(8),
                  children: alphabet.map((e) {
                    return RawMaterialButton(
                      onPressed: Game.selectedChar.contains(e)
                        ? null
                        : () {
                          setState(() {
                            Game.selectedChar.add(e);
                            print(Game.selectedChar);
                            if(!word.split("").contains(e.toUpperCase())) {
                              Game.tries++;
                            }
                          });
                        },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text(e, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold,),),
                      fillColor: Game.selectedChar.contains(e)?Colors.black87:Colors.blue,
                    );
                  }).toList(),
                ),
              )
            ],
          ),
       );
  }
}