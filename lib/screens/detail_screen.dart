import 'package:flutter/material.dart';
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> details;
  late int rating;
  static const int maxRating = 5;
  late String runtime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    details = ApiService.getMoviesDetail(widget.id);
    setState(() {});
  }

  int convertVoteAverage(double currentRating) {
    double targetRating = 5.0;
    double maxRating = 10.0;
    double convertedRating = (currentRating / maxRating) * targetRating;
    return convertedRating.toInt();
  }

  String format(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    return '${hours}h ${remainingMinutes}min';
  }

  onButtonTap(String homepage) async {
    print(homepage);
    var url = Uri.parse(homepage);
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: details,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          rating = convertVoteAverage(snapshot.data!.voteAverage);
          runtime = format(snapshot.data!.runtime);
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/${snapshot.data!.backdropPath}",
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(0.6),
              appBar: AppBar(
                title: const Text(
                  'Back to list',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 150),
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          for (var i = 0; i < maxRating; i++)
                            Icon(
                              Icons.star_rate_rounded,
                              color: i < rating ? Colors.yellow : Colors.grey,
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              '$runtime | ',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            for (var i = 0;
                                i < snapshot.data!.genres.length;
                                i++)
                              Text(
                                '${snapshot.data!.genres[i]}${i != snapshot.data!.genres.length - 1 ? ', ' : ''}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Storyline",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        snapshot.data!.overview,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: GestureDetector(
                          onTap: () => onButtonTap(snapshot.data!.homepage),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(65, 14, 65, 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFf8d849),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Buy ticket",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Text("");
      },
    );
  }
}
