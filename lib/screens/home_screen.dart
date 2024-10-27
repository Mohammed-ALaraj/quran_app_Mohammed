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
  final Map<int, QPage?> pageCache = {};
  int currentPage = 1;

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
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        ...page!.map(
                              (aya) => TextSpan(
                            children: [
                              TextSpan(
                                text: aya.text,
                                style: const TextStyle(fontSize: 23),
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
                                    "${aya.number}",
                                    style: const TextStyle(fontSize: 10),
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
          );
        },
      ),
    );
  }
}
