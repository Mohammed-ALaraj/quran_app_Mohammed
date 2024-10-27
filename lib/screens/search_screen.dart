import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop('ibrahim');
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                context.read<SearchProvider>().onChangeSearchKey(value);
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SearchProvider>().search();
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child:
            Consumer<SearchProvider>(
              builder: (context, provider, child) {
                if(provider.isLoading){
                  return Center(
                    child:  CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var searchResult = provider.searchResult[index];
                    return InkWell(
                      onTap: (){
                        List<String>splited=searchResult.verseKey.split(":");
                        int? suraNum;
                        if(splited.isNotEmpty){
                          suraNum=int.parse(splited.first);
                        }
                        Navigator.pop(context,suraNum);
                      },
                      child: Text("${searchResult.text}"));
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20,),
                  itemCount: provider.searchResult.length,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
