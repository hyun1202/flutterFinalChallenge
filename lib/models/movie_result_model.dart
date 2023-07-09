class MovieResultModel {
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;
  final bool adult, video;
  final double popularity, voteAverage;
  final int id, voteCount;
  final List<dynamic> genreIds;

  MovieResultModel.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        releaseDate = json['release_date'],
        title = json['title'],
        adult = json['adult'],
        video = json['video'],
        popularity = json['popularity'],
        voteAverage = json['vote_average'],
        id = json['id'],
        voteCount = json['vote_count'],
        genreIds = json['genre_ids'];

  static List<MovieResultModel> getResultModel(List<dynamic> json) {
    List<MovieResultModel> list = [];
    for (var result in json) {
      if (result['vote_average'] is int) {
        result['vote_average'] = result['vote_average'].toDouble();
      }
      list.add(MovieResultModel.fromJson(result));
    }
    return list;
  }
}
