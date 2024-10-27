import 'package:flutter/foundation.dart';
import 'package:quran_app/repository/search_repo.dart';

import '../models/search_model.dart';

class SearchProvider extends ChangeNotifier{
  List<VerseResult> searchResult = [];
  String? searchKey;
  bool isLoading=false;
  void onChangeSearchKey(value){
    searchKey=value;
  }

  void search() async {
    if (searchKey!=null) {
      try{
        isLoading=true;
        notifyListeners();
        SearchResponse? searchResponse=await SearchRepo.search(searchKey!);
        if(searchResponse!=null){
          searchResult=searchResponse.search.results;
          isLoading=false;
          notifyListeners();
        }
      }catch(e){
        isLoading=false;
        notifyListeners();
      }
    }
  }
}