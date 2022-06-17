class Movie {
  Movie(
      {required this.bannerUrl,
      required this.posterUrl,
      required this.title,
      required this.rating,
      required this.starRating,
      required this.categories,
      required this.storyline,
      required this.photoUrls,
      required this.actors,
      required this.price,
      required this.like});

  String bannerUrl;
  String posterUrl;
  String title;
  double rating;
  int starRating;
  List<String> categories;
  String storyline;
  List<String> photoUrls;
  List<Actor> actors;
  int price;
  int like;
}

class Actor {
  Actor({
    required this.name,
    required this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
}
