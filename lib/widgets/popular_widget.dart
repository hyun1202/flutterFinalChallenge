import 'package:flutter/material.dart';
import 'package:movie/screens/detail_screen.dart';
import '../models/movie_popular_model.dart';
import '../models/movie_result_model.dart';

class Popular extends StatelessWidget {
  final MoviePopularModel populars;
  const Popular({super.key, required this.populars});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Popular Movies",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 190,
            child: Row(
              children: [
                Expanded(child: makeList(populars)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView makeList(MoviePopularModel populars) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: populars.results.length,
      itemBuilder: (context, index) {
        List<MovieResultModel> result = populars.results;
        return GestureDetector(
          onTap: () {
            int movieId = result[index].id;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(id: movieId),
                ));
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: const Offset(8, 6),
                  color: Colors.black.withOpacity(0.3),
                  // color: Colors.red,
                ),
              ],
            ),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${result[index].backdropPath}",
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
              width: 230,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
    );
  }
}
