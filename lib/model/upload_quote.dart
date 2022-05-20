class UploadQuote {
  final String quote;
  final String quote_category;
  final String image;
  final String time_stemp;
  final String uid;

  const UploadQuote({
    required this.image,
    required this.quote,
    required this.quote_category,
    required this.time_stemp,
    required this.uid,
  });
}
