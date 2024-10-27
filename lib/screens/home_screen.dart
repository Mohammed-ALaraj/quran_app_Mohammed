import 'package:flutter/material.dart';
import 'package:quran_app/models/aya.dart';
import 'package:quran_app/repository/quran_page_repo.dart';
import 'package:quran_app/screens/search_screen.dart';

import '../utils/defs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<int, QPage?> pageCache = {};
  int currentPage = 1;
  double scale = 1.0;

  Future<void> preloadPages(int pageNumber) async {
    if (!pageCache.containsKey(pageNumber)) {
      pageCache[pageNumber] = await QuranPageRepo.getPage(pageNumber);
    }
    if (pageNumber + 1 <= 604 && !pageCache.containsKey(pageNumber + 1)) {
      pageCache[pageNumber + 1] = await QuranPageRepo.getPage(pageNumber + 1);
    }
    if (pageNumber - 1 > 0 && !pageCache.containsKey(pageNumber - 1)) {
      pageCache[pageNumber - 1] = await QuranPageRepo.getPage(pageNumber - 1);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    preloadPages(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              String? value = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );

              print(value);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: 604,
        reverse: true,
        onPageChanged: (index) {
          currentPage = index + 1;
          preloadPages(currentPage);
        },
        itemBuilder: (context, index) {
          final page = pageCache[index + 1];

          return AnimatedOpacity(
            opacity: page != null ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: page == null
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: GestureDetector(
                      onScaleUpdate: (d) {
                        setState(() {
                          scale = d.scale;
                        });
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.justify,
                            // textScaler: TextScaler.linear(scale),
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              children: [
                                ...page!.map(
                                  (aya) => TextSpan(
                                    children: [
                                      WidgetSpan(
                                          child: Visibility(
                                              visible: aya.numberInSurah == 1 &&
                                                  aya.surah != null,
                                              child: Container(
                                                height: 60,
                                                margin: EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/head_of_surah.png"))),
                                                child: Text(
                                                  "${aya.surah!.name}",
                                                  textScaler:
                                                      TextScaler.linear(1),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ))),
                                      TextSpan(
                                        text: aya.text,
                                        style: TextStyle(fontSize: 23 * scale),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/Ayah.png"),
                                            ),
                                          ),
                                          width: 25,
                                          height: 25,
                                          child: Text(
                                            "${aya.numberInSurah}",
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
