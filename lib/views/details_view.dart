import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gym_api/animations/lava_lamp/lava_clock.dart';
import 'package:gym_api/views/definitions_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

class DetailsView extends StatefulWidget {
  final String? word;
  final String? phonetic;
  final String? definition;
  final String? audioUrl;
  final String? sound;
  final String? partOfSpeech;
  final List<dynamic>? partOfSpeech2;
  final List<dynamic>? synonyms;
  final String? antonyms;
  final Color? color;
  final List<dynamic>? def;

  DetailsView(
      {super.key,
      required this.color,
      required this.word,
      this.def,
      this.phonetic,
      this.definition,
      this.audioUrl,
      this.sound,
      this.partOfSpeech,
      this.partOfSpeech2,
      this.synonyms,
      this.antonyms});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final player = AudioPlayer();
  var link = 1;

  @override
  void initState() {
    super.initState();
    fixRangeError();
    loadAud();
  }

  loadAud() async {
    await player.setUrl(widget.sound.toString());
  }

  playAudio() async {
    print('--------${widget.sound.toString()}');
    await player.setUrl(widget.sound.toString());
    player.load();
    player.play();
  }

  fixRangeError() {
    try {
      print(
        '---meanings---${widget.partOfSpeech2![link]['partOfSpeech']}------',
      );
    } catch (e) {
      if (e is RangeError) {
        // handle range error
        link = 0;
        print(
          '---meanings after fix---${link}------',
        );
      } else {
        // handle other types of errors
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                  child: LavaAnimation(
                      color: Colors.redAccent,
                      child: Container(
                        // blur: 10,
                        height: widget.synonyms!.isNotEmpty &&
                                widget.sound!.isNotEmpty
                            ? MediaQuery.of(context).size.height * 1.8
                            : widget.sound!.isNotEmpty
                                ? MediaQuery.of(context).size.height * 1.7
                                : MediaQuery.of(context).size.height * 1.2,
                        width: MediaQuery.of(context).size.width * 1.5,
                        child: const SizedBox(),
                      ))),
              Center(
                  child: LavaAnimation(
                      color: Color.fromARGB(255, 26, 94, 179),
                      child: Container(
                        // blur: 20,
                        height: widget.synonyms!.isNotEmpty
                            ? MediaQuery.of(context).size.height * 1.8
                            : MediaQuery.of(context).size.height * 1.2,
                        width: MediaQuery.of(context).size.width,
                        child: const SizedBox(),
                      ))),
              Center(
                  child: LavaAnimation(
                      color: widget.color,
                      child: Container(
                        // blur: 70,
                        height: widget.synonyms!.isNotEmpty
                            ? MediaQuery.of(context).size.height * 1.8
                            : MediaQuery.of(context).size.height * 1.2,
                        width: MediaQuery.of(context).size.width * 1.5,
                        child: const SizedBox(),
                      ))),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GlassmorphicContainer(
                    blur: 10,
                    borderRadius: 24,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.color!.withOpacity(0.2),
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.02),
                      ],
                      stops: const [0.1, 1],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.2),
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.1),
                      ],
                    ),
                    border: 0.1,
                    height: widget.synonyms!.isNotEmpty && widget.sound!.isEmpty
                        ? MediaQuery.of(context).size.height * 1.8
                        : widget.synonyms!.isNotEmpty &&
                                widget.sound!.isNotEmpty
                            ? MediaQuery.of(context).size.height * 1.95
                            : widget.synonyms!.isEmpty && widget.sound!.isEmpty
                                ? MediaQuery.of(context).size.height * 1.2
                                : MediaQuery.of(context).size.height * 1.4,
                    width: MediaQuery.of(context).size.width,
                  )),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 40),
                        child: Row(
                          children: [
                            Text(
                              widget.partOfSpeech.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            link != 0
                                ? Text(
                                    ', ${widget.partOfSpeech2![link]['partOfSpeech'].toString()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    child: Text(
                      widget.word.toString(),
                      style: GoogleFonts.elsieSwashCaps(
                          fontSize: 45, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    widget.phonetic.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      child: Lottie.asset(
                          'lib/animations/scroll-down-circle.json')),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 40, right: 40),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            widget.definition.toString(),
                            style: GoogleFonts.elsieSwashCaps(
                                fontSize: 32, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade800, width: 1),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                print(widget.def!.length);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => DefinitionsScreen(
                                //     color: widget.color,
                                //     defs: widget.def,
                                //     def2: widget.partOfSpeech2,
                                //     def1: widget.partOfSpeech,
                                //   ),
                                // ));

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        DefinitionsScreen(
                                      color: widget.color,
                                      defs: widget.def,
                                      def2: widget.partOfSpeech2,
                                      def1: widget.partOfSpeech,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'More Definitions',
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey.shade800,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 40),
                    child: Divider(thickness: 2),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  widget.synonyms!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            'Synonyms',
                            style: GoogleFonts.elsieSwashCaps(
                                fontSize: 40, fontWeight: FontWeight.w600),
                          ),
                        )
                      : const SizedBox(),
                  widget.synonyms!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Colors.black.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20, right: 20),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: widget.synonyms!.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      widget.synonyms![index].toString(),
                                      style: GoogleFonts.elsieSwashCaps(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
                                    );
                                  },
                                )),
                          ),
                        )
                      : const SizedBox(),
                  widget.sound!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            'Sound',
                            style: GoogleFonts.elsieSwashCaps(
                                fontSize: 40, fontWeight: FontWeight.w600),
                          ),
                        )
                      : const SizedBox(),
                  widget.sound!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(30)),
                            child: InkWell(
                                onTap: () {
                                  playAudio();
                                  Future.delayed(
                                    const Duration(
                                      milliseconds: 500,
                                    ),
                                    () {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      player.playerState.playing
                                          ? 'Replay'
                                          : 'Play',
                                      style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        player.playerState.playing
                                            ? Icons.replay
                                            : Icons.play_arrow_outlined,
                                        size: 26,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
