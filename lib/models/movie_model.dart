import 'movie_result_model.dart';

class MovieModel {
  final int page, totalPages, totalResults;
  final Map<String, dynamic> dates;
  final List<MovieResultModel> results;

  MovieModel.fromJson(Map<String, dynamic> json)
      : dates = json['dates'],
        page = json['page'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'],
        results = MovieResultModel.getResultModel(json['results']);
}
