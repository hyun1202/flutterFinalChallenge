import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';

import '../models/movie_result_model.dart';
import '../screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final MovieModel movieData;
  final String title;
  const Movie({super.key, required this.movieData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 185,
            child: Row(
              children: [
                Expanded(child: makeList(movieData)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView makeList(MovieModel populars) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: populars.results.length,
      itemBuilder: (context, index) {
        List<MovieResultModel> result = populars.results;
        return GestureDetector(
          onTap: () {
            int movieId = result[index].id;
            print(movieId);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(id: movieId),
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(8, 6),
                      color: Colors.black.withOpacity(0.2),
                      // color: Colors.red,
                    ),
                  ],
                ),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500/${result[index].posterPath}",
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                  width: 120,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  result[index].title.length < 40
                      ? result[index].title
                      : result[index].title.substring(0, 40),
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
    );
  }
}
