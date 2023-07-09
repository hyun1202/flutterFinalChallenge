import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/models/movie_popular_model.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/widgets/popular_widget.dart';

import '../widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<MoviePopularModel> populars = ApiService.getPopularMovies();
  final Future<MovieModel> moviePlayings = ApiService.getMoviePlaying();
  final Future<MovieModel> comingSoons = ApiService.getMoviesBeReleased();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: populars,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MoviePopularModel popular =
                        snapshot.data as MoviePopularModel;
                    return Popular(populars: popular);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: moviePlayings,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MovieModel moviePlaying = snapshot.data as MovieModel;
                    return Movie(
                      movieData: moviePlaying,
                      title: 'Now in Cinemas',
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: comingSoons,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MovieModel comingSoon = snapshot.data as MovieModel;
                    return Movie(
                      movieData: comingSoon,
                      title: 'Coming soon',
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
