import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsView extends StatefulWidget {
  final String? word;
  final String? phonetic;
  final String? definition;
  final String? audioUrl;
  final String? sound;
  final String? partOfSpeech;
  final String? synonyms;
  final String? antonyms;

  DetailsView(
      {super.key,
      required this.word,
      this.phonetic,
      this.definition,
      this.audioUrl,
      this.sound,
      this.partOfSpeech,
      this.synonyms,
      this.antonyms});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 0, 151, 111),
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
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "noun",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Text(
                  'Forest',
                  style: GoogleFonts.elsieSwashCaps(
                      fontSize: 45, fontWeight: FontWeight.w600),
                ),
              ),
              const Text(
                "/ˈfɒrɪst/",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Text(
                  'a large area covered chiefly with trees and undergrowth.',
                  style: GoogleFonts.elsieSwashCaps(
                      fontSize: 35, fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Divider(thickness: 2),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Text(
                  'a large area covered chiefly with trees and undergrowth.',
                  style: GoogleFonts.elsieSwashCaps(
                      fontSize: 35, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
