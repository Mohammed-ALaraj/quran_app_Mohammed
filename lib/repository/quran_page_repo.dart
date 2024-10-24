import 'package:quran_app/models/aya.dart';
import 'package:quran_app/network/network_helper.dart';

class QuranPageRepo {
 static Future<List<Aya>> getPage(int pageNumber)async{
    Map<String, dynamic>? response= await NetworkHelper("https://api.alquran.cloud/v1/page/$pageNumber/quran-uthmani").getData();
    if(response!=null){
     Map? data= response["data"];
     if(data!=null) {
        List ayahs = data["ayahs"] ?? [];
         // ayahs.map((aya)=>Aya.fromJson(aya)).toList();
        return List.generate(ayahs.length, (index)=>Aya.fromJson(ayahs[index]));
      }
    }
    return [];
  }
}