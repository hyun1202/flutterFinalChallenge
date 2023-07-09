import 'movie_result_model.dart';

class MoviePopularModel {
  final int page, totalPages, totalResults;
  final List<MovieResultModel> results;

  MoviePopularModel.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'],
        results = MovieResultModel.getResultModel(json['results']);
}
