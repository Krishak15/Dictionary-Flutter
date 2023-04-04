import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
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
    // TODO: implement initState
    super.initState();
    fixRangeError();
    loadAud();
  }

  loadAud() async {
    await player.setUrl(widget.sound.toString());
  }

  playAudio() async {
    print(
        '---------------------------------------------${widget.sound.toString()}');
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
        color: widget.color,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )
                            : const SizedBox()
                      ],
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    print(widget.partOfSpeech2!.length);
                    print(widget.partOfSpeech2);
                  },
                  child: Text(
                    widget.word.toString(),
                    style: GoogleFonts.elsieSwashCaps(
                        fontSize: 45, fontWeight: FontWeight.w600),
                  ),
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
                  child:
                      Lottie.asset('lib/animations/scroll-down-circle.json')),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Text(
                  widget.definition.toString(),
                  style: GoogleFonts.elsieSwashCaps(
                      fontSize: 35, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade800, width: 1),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            print(widget.def!.length);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DefinitionsScreen(
                                color: widget.color,
                                defs: widget.def,
                                def2: widget.partOfSpeech2,
                                def1: widget.partOfSpeech,
                              ),
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                padding: EdgeInsets.all(20.0),
                child: Divider(thickness: 2),
              ),
              const SizedBox(
                height: 15,
              ),
              widget.synonyms!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20, right: 20, bottom: 15),
                      child: Text(
                        'Synonyms',
                        style: GoogleFonts.elsieSwashCaps(
                            fontSize: 40, fontWeight: FontWeight.w600),
                      ),
                    )
                  : const SizedBox(),
              widget.synonyms!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.black.withOpacity(0.2)),
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
        ),
      ),
    );
  }
}
