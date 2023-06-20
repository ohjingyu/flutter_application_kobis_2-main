import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_2/kobis_api.dart';
import 'package:flutter_application_kobis_2/movie_detail.dart';

class RankPage extends StatefulWidget {
  const RankPage({
    super.key,
  });

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final kobisApi = KobisApi(apiKey: '68e44fd6eab931b1a515299e75d9562e');
  dynamic body = const Center(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Movies!',
        style: TextStyle(fontSize: 50),
      ),
      Icon(
        Icons.movie_creation_outlined,
        size: 50,
      )
    ],
  ));

  void showCal() async {
    var dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2023, 01, 01),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      locale: const Locale('ko', 'KR'), // 한국어 설정
    );
    var targetDt = dt.toString().split(' ')[0].replaceAll('-', '');
    var movies = kobisApi.getDailyBoxOffice(targetDt: targetDt);
    showList(movies);
  }

  void showList(Future<List<dynamic>> movies) {
    setState(() {
      body = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //데이터가 넘어옴
            var movies = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var rankColor = Colors.white;
                  if (index == 0) {
                    rankColor = Colors.lightBlueAccent;
                  } else if (index == 1) {
                    rankColor = Colors.lightGreenAccent;
                  } else if (index == 2) {
                    rankColor = Colors.yellowAccent;
                  }
                  return ListTile(
                    tileColor: Colors.black,
                    textColor: Colors.white,
                    leading: Container(
                      width: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: rankColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        movies[index]['rank'],
                        style: TextStyle(color: Colors.grey),
                      )),
                    ),
                    title: Text(movies[index]['movieNm']),
                    subtitle: Text('${movies[index]['audiCnt']}명'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetail(
                                    movieCd: movies[index]['movieCd'],
                                  )));
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                //!를 붙이면 movies안에 무조건 값이 있다는 뜻이다
                itemCount: movies!.length);
          } else if (snapshot.hasError) {
            //오류남
            return Text(snapshot.error.toString());
          } else {
            //로딩중
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('영화 랭킹보기')),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showCal,
        child: const Icon(Icons.calendar_month),
      ),
    );
  }
}
