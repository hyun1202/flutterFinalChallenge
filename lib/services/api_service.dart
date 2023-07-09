import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/models/movie_popular_model.dart';
import 'package:movie/models/webtoon_detail_model.dart';
import 'package:movie/models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<MoviePopularModel> getPopularMovies() async {
    final url = Uri.parse('$baseUrl/popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var populars = jsonDecode(response.body);
      return MoviePopularModel.fromJson(populars);
    }
    throw Error();
  }

  static Future<MovieModel> getMoviePlaying() async {
    final url = Uri.parse('$baseUrl/now-playing');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var playing = jsonDecode(response.body);
      return MovieModel.fromJson(playing);
    }
    throw Error();
  }

  static Future<MovieModel> getMoviesBeReleased() async {
    final url = Uri.parse('$baseUrl/coming-soon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var comingSoon = jsonDecode(response.body);
      return MovieModel.fromJson(comingSoon);
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMoviesDetail(int id) async {
    List<String> genresName = [];
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var details = jsonDecode(response.body);
      for (var genre in details['genres']) {
        genresName.add(genre['name']);
      }
      if (details?['belongs_to_collection']?['backdrop_path'] != null) {
        details['backdrop_path'] =
            details['belongs_to_collection']['backdrop_path'];
      }
      details['genresName'] = genresName;
      return MovieDetailModel.fromJson(details);
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    // print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        // print(episode);
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
