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
  
  void getPage()async{
    page= await QuranPageRepo.getPage(1);
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
      body:page==null?
         Center(child: CircularProgressIndicator(),)
          : Center(
            child: Wrap(
              textDirection: TextDirection.rtl,
                    children: page!.map((aya)=>Text(

              aya.text??"")).toList(),
                  ),
          ),
    );
  }
}
