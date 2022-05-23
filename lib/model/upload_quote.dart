class UploadQuote {
  final String quote;
  final String quote_category;
  final String image;
  final int time;
  final String uid;
  final String searchType;

  const UploadQuote({
    required this.image,
    required this.quote,
    required this.quote_category,
    required this.time,
    required this.uid,
    required this.searchType,
  });
}
