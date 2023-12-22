
class FAQItem {
  int id;
  String query;
  String response;
  FAQItem(
      {
        required this.id, required this.query, required this.response
      }
      );
  factory FAQItem.fromJson(Map<String, dynamic> json) {
    return FAQItem(
      id: json['id'] ?? 0,
      query: json['query'] ?? '',
      response: json['response'] ?? ''
    );
  }
}
