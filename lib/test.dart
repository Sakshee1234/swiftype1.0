import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: AutoComplete(),
    );
  }
}
class AutoComplete extends StatefulWidget {
  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  List<String> _suggestions = [];
  TextEditingController _textEditingController = TextEditingController();

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) return;

    final response = await http.get(Uri.parse('https://api.datamuse.com/sug?s=$query'));

    if (response.statusCode == 200) {
      setState(() {
        final List<dynamic> suggestionsJson = json.decode(response.body);
        _suggestions = suggestionsJson.map((dynamic suggestion)  => suggestion['word']).cast<String>().toList();
      });
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete Demo'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            onChanged: (query) => _fetchSuggestions(query),
            decoration: InputDecoration(
              hintText: 'Type a word',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    final newText = _textEditingController.text.replaceAll(RegExp(r'\b\w+$'), suggestion);
                    _textEditingController.text = newText;
                    setState(() {
                      _suggestions.clear();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
