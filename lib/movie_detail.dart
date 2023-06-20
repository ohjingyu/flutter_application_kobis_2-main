import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_2/kobis_api.dart';
import 'package:flutter_application_kobis_2/movie_datail_view.dart';

class MovieDetail extends StatelessWidget {
  String movieCd;
  MovieDetail({super.key, required this.movieCd});
  final kobisApi = KobisApi(apiKey: '883d6f8d0a2cc7e4c4f3af62430196be');

  void asd() {
    var movie = kobisApi.getMovieDetail(movieCd: movieCd);
  }

  @override
  Widget build(BuildContext context) {
    var movieData = kobisApi.getMovieDetail(movieCd: movieCd);
    asd();
    return Scaffold(
      appBar: AppBar(title: const Text('영화 상세정보')),
      body: FutureBuilder(
        future: movieData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movie = snapshot.data;
            return MovieDetailView(movie: movie);
          } else {
            var msg = '데이터 로드중입니다.';
            return Center(child: Text(msg));
          }
        },
      ),
    );
  }
}
