import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchTextController = TextEditingController();
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: _searchTextController,
                maxLength: null,
                decoration: const InputDecoration(
                    hintText: "Search", border: UnderlineInputBorder()),
              )),
              TextButton(onPressed: () {}, child: Icon(Icons.search)),
            ],
            
          ),
          Container(child: Text("Content"),)
        ],
      ),
    );
  }
}
