import 'dart:math';
import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_api/animations/lava_lamp/lava_clock.dart';
import 'package:gym_api/models/colors.dart';

import 'package:gym_api/services/services.dart';
import 'package:gym_api/views/details_view.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  final DictionaryController controller = Get.put(DictionaryController());

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    @override
    var dictionaryData = widget.controller.definition.value;

    void searchFunctions() {
      widget.controller.fetchDefinition(textEditingController.text);
      setState(() {
        widget.controller.isLoading = true;
        widget.controller.fetchDefinition(textEditingController.text);
      });

      if (widget.controller.isLoading == true) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (widget.controller.noSuchWord == true) {
            setState(() {
              if (kDebugMode) {
                print('Search Loading...');
              }
            });
          }
        });
      }
    }

//rando color generation
    Color getRandomColor() {
      final random = Random();
      return predefinedColors[random.nextInt(predefinedColors.length)];
    }

    void initState() {
      super.initState();
      getRandomColor();
    }

    Color randomColor = getRandomColor();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 82, 82),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('English Dictionary')),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 247, 82, 82),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(0, 2),
                                  blurRadius: 8)
                            ],
                            borderRadius: BorderRadius.circular(22)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                cursorColor: Colors.red.shade300,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (_) {
                                  searchFunctions();
                                },
                                controller: textEditingController,
                                // onSubmitted: (word) {
                                //   widget.controller.fetchDefinition(word);
                                //   print(word);
                                // },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade100,
                                          width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: 'Enter a word',
                                )),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        searchFunctions();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(0, 2),
                                  blurRadius: 8)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(1, 0),
                                blurRadius: 5,
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: Stack(
                        children: [
                          const Center(
                              child: LavaAnimation(
                                  color: Colors.redAccent,
                                  child: BlurryContainer(
                                    blur: 30,
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: SizedBox(),
                                  ))
                              // RiveAnimation.asset(
                              //     'assets/rive/spheres.riv')
                              ),
                          // SizedBox(
                          //   height: 50,
                          //   child: BackdropFilter(
                          //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          //     child: const SizedBox(),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 15, top: 20, right: 20),
                            child: widget.controller.noSuchWord == false
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   'Word',
                                      //   style: GoogleFonts.poppins(
                                      //       color: Colors.black.withOpacity(0.6),
                                      //       fontSize: 18,
                                      //       fontWeight: FontWeight.w500),
                                      // ),

                                      widget.controller.isLoading == true
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Color.fromARGB(
                                                    255, 247, 82, 82),
                                                strokeWidth: 1,
                                              ),
                                            )
                                          : Text(''),

                                      widget.controller.definition.value.word !=
                                              ''
                                          ? Text(
                                              widget.controller.isLoading ==
                                                      false
                                                  ? widget.controller.definition
                                                      .value.word
                                                  : '',
                                              style: GoogleFonts.elsieSwashCaps(
                                                fontSize: 45,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          : Text(
                                              widget.controller.isLoading ==
                                                      true
                                                  ? 'Search a word'
                                                  : '',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                      widget.controller.isLoading == false
                                          ? Center(
                                              child: Text(
                                                widget.controller.definition
                                                            .value.word !=
                                                        ''
                                                    ? '[${widget.controller.definition.value.phonetic}]'
                                                    : '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      widget.controller.isLoading == false
                                          ? Container(
                                              height: 50,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    getRandomColor();
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsView(
                                                        word: widget
                                                            .controller
                                                            .definition
                                                            .value
                                                            .word,
                                                        color: randomColor,
                                                        phonetic: widget
                                                            .controller
                                                            .definition
                                                            .value
                                                            .phonetic,
                                                        partOfSpeech: widget
                                                                .controller
                                                                .definition
                                                                .value
                                                                .meanings[0]
                                                            ['partOfSpeech'],
                                                        partOfSpeech2: widget
                                                            .controller
                                                            .definition
                                                            .value
                                                            .meanings,
                                                        definition: widget
                                                                        .controller
                                                                        .definition
                                                                        .value
                                                                        .meanings[0]
                                                                    [
                                                                    'definitions'][0]
                                                                [
                                                                'definition'] ??
                                                            '',
                                                        synonyms: widget
                                                                    .controller
                                                                    .definition
                                                                    .value
                                                                    .meanings[0]
                                                                ['synonyms'] ??
                                                            [],
                                                        def: widget
                                                                    .controller
                                                                    .definition
                                                                    .value
                                                                    .meanings[0]
                                                                [
                                                                'definitions'] ??
                                                            [],
                                                        sound: widget
                                                                    .controller
                                                                    .definition
                                                                    .value
                                                                    .phonetics[
                                                                0]['audio'] ??
                                                            'https://api.dictionaryapi.dev/media/pronunciations/en/cat-us.mp3',
                                                      ),
                                                    ));
                                                    print(
                                                        '-----------------------${widget.controller.definition.value.meanings[0]['synonyms']}');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      widget.controller
                                                                  .isLoading ==
                                                              false
                                                          ? Text(
                                                              'Details',
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )
                                                          : const Center(
                                                              child: SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .black,
                                                                      strokeWidth:
                                                                          1,
                                                                    ),
                                                                  ))),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      widget.controller
                                                                  .isLoading ==
                                                              false
                                                          ? const Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 18,
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                : Center(
                                    child: widget.controller.isLoading == false
                                        ? Text('No such word found')
                                        : const Center(
                                            child: CircularProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 247, 82, 82),
                                              strokeWidth: 1,
                                            ),
                                          ),
                                  ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
