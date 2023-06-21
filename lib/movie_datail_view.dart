import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_2/kobis_api.dart';

class MovieDetailView extends StatefulWidget {
  Map<String, dynamic> movie;
  MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  void showPopup() async {
    var kobisApi = KobisApi(apiKey: '883d6f8d0a2cc7e4c4f3af62430196be');
    var company = await kobisApi.getCompanyDetail(
        companyCd: widget.movie['companys'][0]['companyCd']);
    var msg = showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('${company['companyNm']}'),
              content: Text('company info'),
              actions: [
                TextButton(onPressed: null, child: Text('아니오')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('예'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movie);
    var grade = widget.movie['audits'][0]['watchGradeNm'].toString();
    Map<String, dynamic> grade_style = {};
    if (grade == '15세이상관람가') {
      grade_style['color'] = Colors.blue;
      grade_style['text'] = '15';
    }
    return Column(
      children: [
        Text('${widget.movie['movieNm']}(${widget.movie['prdtYear']})'),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: grade_style['color'], shape: BoxShape.circle),
            ),
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Center(
                child: Text(grade_style['text']),
              ),
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              showPopup();
            },
            child: Text('${widget.movie['companys'][0]['companyCd']}'))
      ],
    );
  }
}
