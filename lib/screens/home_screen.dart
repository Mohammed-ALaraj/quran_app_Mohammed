import 'package:flutter/material.dart';
import 'package:quran_app/models/aya.dart';
import 'package:quran_app/repository/quran_page_repo.dart';

import '../utils/defs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QPage? page;

  void getPage() async {
    page = await QuranPageRepo.getPage(1);
    print(page);
    setState(() {});
  }

  @override
  void initState() {
    getPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Center(
                    child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        ...page!.map(
                          (aya) => TextSpan(
                            text: aya.text,
                          ),
                          
                        ),
                      ],
                    ),
                  ),
                )
                    // Wrap(
                    //   textDirection: TextDirection.rtl,
                    //   children: page!
                    // .map(
                    //   (aya) => Text(aya.text ?? ""),
                    // )
                    //       .toList(),
                    // ),
                    );
              },
            ),
    );
  }
}
