import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_2/kobis_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  var _searchType = 'movieNm';
  var kobisApi = KobisApi(apiKey: '883d6f8d0a2cc7e4c4f3af62430196be');

  void getMovieList() async {
    var movies = await kobisApi.getSeachMovieList(
        searchType: _searchType, SearchValue: controller.text);
    for (var movie in movies) {
      print(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DropdownButton(
            items: [
              DropdownMenuItem(value: 'movieNm', child: Text('영화제목')),
              DropdownMenuItem(value: 'directorNm', child: Text('감독명'))
            ],
            onChanged: (value) {
              _searchType = value.toString();
            },
          ),
          Expanded(
              child: TextFormField(
            autofocus: true,
            controller: controller,
          )),
          ElevatedButton(onPressed: getMovieList, child: Text('검색'))
        ],
      ),
    );
  }
}
