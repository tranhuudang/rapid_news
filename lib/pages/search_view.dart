

import 'package:flutter/material.dart';
import 'package:rapid/pages/listFoundedNews_view.dart';
import 'package:rapid/rapidProp.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}



class _SearchState extends State<Search> {

  @override
  void initState()
  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 30,left: 30,right: 30),
          child: Row(

          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.search,
                maxLength: 30,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                onSubmitted: (text){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListFoundedNews(text)));
                },
              ),
            ),
            // IconButton(
            //   onPressed: null,
            //   icon: Icon(Icons.search),
            // )
          ],
      ),
        ),
    ],
    );
  }
}
