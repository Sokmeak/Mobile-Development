// Model for Testimonial data
class Testimonial {
  final String quote;
  final String author;
  final String authorTitle;
  final String imageUrl;
  final String category;

  Testimonial({
    required this.quote,
    required this.author,
    required this.authorTitle,
    required this.imageUrl,
    required this.category,
  });
}