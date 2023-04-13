import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_api/animations/lava_lamp/lava_clock.dart';
import 'package:gym_api/models/colors.dart';

import 'package:gym_api/services/services.dart';
import 'package:gym_api/views/details_view.dart';

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
      extendBody: true,

      // backgroundColor: const Color.fromARGB(255, 247, 82, 82),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'English Dictionary',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 24),
          )),
      body: Stack(
        children: [
          Center(
              child: LavaAnimation(
                  color: Colors.redAccent,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 3,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ))
              // RiveAnimation.asset(
              //     'assets/rive/spheres.riv')
              ),
          Center(
              child: LavaAnimation(
                  color: const Color.fromARGB(255, 100, 61, 242),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ))
              // RiveAnimation.asset(
              //     'assets/rive/spheres.riv')
              ),
          Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GlassmorphicContainer(
                            blur: 10,
                            borderRadius: 24,
                            linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color!
                                    .withOpacity(0.02),
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
                            height: 90,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextField(
                                          style: GoogleFonts.poppins(
                                              color: const Color.fromARGB(
                                                  255, 22, 1, 130),
                                              fontSize: 20),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          cursorColor: const Color.fromARGB(
                                              255, 121, 37, 255),
                                          textInputAction:
                                              TextInputAction.search,
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        116, 232, 88, 143),
                                                    width: 2)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            hintText: 'Enter a word',
                                          )),
                                    ),
                                  ),
                                ),
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
                      () => Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GlassmorphicContainer(
                          blur: 10,
                          borderRadius: 24,
                          linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple.withOpacity(0.02),
                              const Color.fromARGB(255, 9, 119, 237)
                                  .withOpacity(0.2),
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
                          height: 80,
                          width: double.infinity,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25)),
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(1, 0),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: Stack(
                                children: [
                                  // SizedBox(
                                  //   height: 50,
                                  //   child: BackdropFilter(
                                  //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  //     child: const SizedBox(),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        bottom: 15,
                                        top: 20,
                                        right: 20),
                                    child: widget.controller.noSuchWord == false
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Text(
                                              //   'Word',
                                              //   style: GoogleFonts.poppins(
                                              //       color: Colors.black.withOpacity(0.6),
                                              //       fontSize: 18,
                                              //       fontWeight: FontWeight.w500),
                                              // ),

                                              widget.controller.isLoading ==
                                                      true
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              159,
                                                              159),
                                                          strokeWidth: 2,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(''),

                                              widget.controller.definition.value
                                                          .word !=
                                                      ''
                                                  ? Text(
                                                      widget.controller
                                                                  .isLoading ==
                                                              false
                                                          ? widget
                                                              .controller
                                                              .definition
                                                              .value
                                                              .word
                                                          : '',
                                                      style: GoogleFonts
                                                          .elsieSwashCaps(
                                                              fontSize: 45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  19,
                                                                  20,
                                                                  20)),
                                                    )
                                                  : Text(
                                                      widget.controller
                                                                  .isLoading ==
                                                              true
                                                          ? 'Search a word'
                                                          : '',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                              widget.controller.isLoading ==
                                                      false
                                                  ? Center(
                                                      child: Text(
                                                        widget
                                                                    .controller
                                                                    .definition
                                                                    .value
                                                                    .word !=
                                                                ''
                                                            ? '[${widget.controller.definition.value.phonetic}]'
                                                            : '',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(
                                                height: 100,
                                              ),
                                              widget.controller.isLoading ==
                                                      false
                                                  ? Container(
                                                      height: 50,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            getRandomColor();

                                                            Navigator.push(
                                                              context,
                                                              PageRouteBuilder(
                                                                transitionDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                pageBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                    DetailsView(
                                                                  word: widget
                                                                      .controller
                                                                      .definition
                                                                      .value
                                                                      .word,
                                                                  color:
                                                                      randomColor,
                                                                  phonetic: widget
                                                                      .controller
                                                                      .definition
                                                                      .value
                                                                      .phonetic,
                                                                  partOfSpeech: widget
                                                                      .controller
                                                                      .definition
                                                                      .value
                                                                      .meanings[0]['partOfSpeech'],
                                                                  partOfSpeech2: widget
                                                                      .controller
                                                                      .definition
                                                                      .value
                                                                      .meanings,
                                                                  definition: widget
                                                                          .controller
                                                                          .definition
                                                                          .value
                                                                          .meanings[0]['definitions'][0]['definition'] ??
                                                                      '',
                                                                  synonyms: widget
                                                                          .controller
                                                                          .definition
                                                                          .value
                                                                          .meanings[0]['synonyms'] ??
                                                                      [],
                                                                  def: widget
                                                                          .controller
                                                                          .definition
                                                                          .value
                                                                          .meanings[0]['definitions'] ??
                                                                      [],
                                                                  sound: widget
                                                                          .controller
                                                                          .definition
                                                                          .value
                                                                          .phonetics[0]['audio'] ??
                                                                      'https://api.dictionaryapi.dev/media/pronunciations/en/cat-us.mp3',
                                                                ),
                                                                transitionsBuilder:
                                                                    (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                  var begin =
                                                                      const Offset(
                                                                          1.0,
                                                                          0.0);
                                                                  var end =
                                                                      Offset
                                                                          .zero;
                                                                  var curve = Curves
                                                                      .easeInOutQuart;

                                                                  var tween = Tween(
                                                                          begin:
                                                                              begin,
                                                                          end:
                                                                              end)
                                                                      .chain(CurveTween(
                                                                          curve:
                                                                              curve));

                                                                  return SlideTransition(
                                                                    position: animation
                                                                        .drive(
                                                                            tween),
                                                                    child:
                                                                        child,
                                                                  );
                                                                },
                                                              ),
                                                            );

                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //         MaterialPageRoute(
                                                            //   builder:
                                                            //       (context) =>
                                                            //           DetailsView(
                                                            //     word: widget
                                                            //         .controller
                                                            //         .definition
                                                            //         .value
                                                            //         .word,
                                                            //     color:
                                                            //         randomColor,
                                                            //     phonetic: widget
                                                            //         .controller
                                                            //         .definition
                                                            //         .value
                                                            //         .phonetic,
                                                            //     partOfSpeech: widget
                                                            //             .controller
                                                            //             .definition
                                                            //             .value
                                                            //             .meanings[0]
                                                            //         [
                                                            //         'partOfSpeech'],
                                                            //     partOfSpeech2: widget
                                                            //         .controller
                                                            //         .definition
                                                            //         .value
                                                            //         .meanings,
                                                            //     definition: widget
                                                            //             .controller
                                                            //             .definition
                                                            //             .value
                                                            //             .meanings[0]['definitions'][0]['definition'] ??
                                                            //         '',
                                                            //     synonyms: widget
                                                            //             .controller
                                                            //             .definition
                                                            //             .value
                                                            //             .meanings[0]['synonyms'] ??
                                                            //         [],
                                                            //     def: widget
                                                            //             .controller
                                                            //             .definition
                                                            //             .value
                                                            //             .meanings[0]['definitions'] ??
                                                            //         [],
                                                            //     sound: widget
                                                            //             .controller
                                                            //             .definition
                                                            //             .value
                                                            //             .phonetics[0]['audio'] ??
                                                            //         'https://api.dictionaryapi.dev/media/pronunciations/en/cat-us.mp3',
                                                            //   ),
                                                            // ));
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
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    )
                                                                  : const Center(
                                                                      child: SizedBox(
                                                                          height: 20,
                                                                          width: 20,
                                                                          child: Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              color: Colors.black,
                                                                              strokeWidth: 1,
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
                                            child:
                                                widget.controller.isLoading ==
                                                        false
                                                    ? Text('No such word found')
                                                    : const Center(
                                                        child:
                                                            CircularProgressIndicator(
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
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
