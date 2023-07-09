class MovieDetailModel {
  final String backdropPath, homepage, title, overview;
  final int id, runtime;
  final double voteAverage;
  final List<String> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        backdropPath = json['backdrop_path'] ?? "",
        homepage = json['homepage'],
        title = json['title'],
        overview = json['overview'],
        runtime = json['runtime'],
        voteAverage = json['vote_average'],
        genres = json['genresName'];
}
