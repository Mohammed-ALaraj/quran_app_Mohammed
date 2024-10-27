class SearchResponse {
  final Search search;

  SearchResponse({required this.search});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      search: Search.fromJson(json['search']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'search': search.toJson()};
  }
}

class Search {
  final String query;
  final int totalResults;
  final int currentPage;
  final int totalPages;
  final List<VerseResult> results;

  Search({
    required this.query,
    required this.totalResults,
    required this.currentPage,
    required this.totalPages,
    required this.results,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      query: json['query'],
      totalResults: json['total_results'],
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
      results: (json['results'] as List)
          .map((item) => VerseResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'total_results': totalResults,
      'current_page': currentPage,
      'total_pages': totalPages,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}

class VerseResult {
  final String verseKey;
  final int verseId;
  final String text;
  final List<Word> words;
  final List<dynamic> translations; // Adjust based on your JSON structure

  VerseResult({
    required this.verseKey,
    required this.verseId,
    required this.text,
    required this.words,
    required this.translations,
  });

  factory VerseResult.fromJson(Map<String, dynamic> json) {
    return VerseResult(
      verseKey: json['verse_key'] ?? '',
      verseId: json['verse_id'] ?? 0,
      text: json['text'] ?? '',
      words:
          (json['words'] as List).map((item) => Word.fromJson(item)).toList(),
      translations: json['translations'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verse_key': verseKey,
      'verse_id': verseId,
      'text': text,
      'words': words.map((item) => item.toJson()).toList(),
      'translations': translations,
    };
  }
}

class Word {
  final String charType;
  final String text;
  final bool? highlight;

  Word({
    required this.charType,
    required this.text,
    this.highlight,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      charType: json['char_type'],
      text: json['text'],
      highlight: json['highlight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'char_type': charType,
      'text': text,
      'highlight': highlight,
    };
  }
}
