import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import 'package:google_fonts/google_fonts.dart';

import '../animations/lava_lamp/lava_clock.dart';

class DefinitionsScreen extends StatefulWidget {
  final Color? color;
  List<dynamic>? defs;
  final String? def1;
  final List<dynamic>? def2;
  final String? def3;
  final String? def4;

  DefinitionsScreen(
      {super.key,
      this.color,
      this.defs,
      this.def1,
      this.def2,
      this.def3,
      this.def4});

  @override
  State<DefinitionsScreen> createState() => _DefinitionsScreenState();
}

class _DefinitionsScreenState extends State<DefinitionsScreen> {
  var link = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fixRangeError();
  }

  fixRangeError() {
    try {
      print(
        '---meanings---${widget.def2![link]['definitions']}------',
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
    List<dynamic> partofSp = widget.def2![link]['definitions'];
    bool isPartofSpClicked = false;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Center(
                child: LavaAnimation(
                    color: widget.color,
                    child: Container(
                      // blur: 10,
                      height: MediaQuery.of(context).size.height * 1.2,
                      width: MediaQuery.of(context).size.width * 1.5,
                      child: const SizedBox(),
                    ))),
            Center(
                child: LavaAnimation(
                    color: Colors.redAccent,
                    child: Container(
                      // blur: 10,
                      height: MediaQuery.of(context).size.height * 1.8,
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
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width,
                )),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40.0, top: 40, bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Definitions',
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.def1.toString(),
                          style: GoogleFonts.elsieSwashCaps(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: link == 0
                        ? const EdgeInsets.only(
                            left: 30.0, right: 30, top: 10, bottom: 40)
                        : const EdgeInsets.only(
                            left: 30.0, right: 30, top: 10, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(0.2))),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.defs!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 20, right: 30),
                                  child: Text(
                                    widget.defs![index]['definition']
                                        .toString(),
                                    style: GoogleFonts.elsieSwashCaps(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                link != 0
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.def2![link]['partOfSpeech'].toString(),
                                style: GoogleFonts.elsieSwashCaps(
                                    fontSize: 35, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                link != 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 30.0,
                            left: 30,
                            right: 30,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.2))),
                            child: ListView.builder(
                              itemCount: partofSp.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25.0, left: 20, right: 30),
                                        child: Text(
                                          widget.def2![link]['definitions']
                                                  [index]['definition']
                                              .toString(),
                                          style: GoogleFonts.elsieSwashCaps(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
