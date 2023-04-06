import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget 
{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController typing = TextEditingController();
  List<String> _autocompleteSuggestions = [];

  Future<List> _getAutocompleteSuggestions(String query) async {
    String apiUrl = "https://api.datamuse.com/words?max=5&sp=$query*";
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) 
    {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((word) => word['word']).toList();
    } 
    else 
    {
      throw Exception('Failed to load suggestions');
    }
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                
                // SizedBox(
                //   height: 25,
                // ),
                SizedBox(
                    width: 350, // <-- TextField width// <-- TextField height
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          maxLines: 10,
                          cursorColor: Colors.black,
                          autocorrect: true,
                          controller: typing,
                          decoration: InputDecoration(
                            hintText: 'Start Typing...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.isEmpty) {
                            return [];
                          }
                          return await _getAutocompleteSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(title: Text(suggestion));
                        },
                        onSuggestionSelected: (suggestion) {
                          typing.text = suggestion;
                        },
                      ),
                    ),
                    
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: (){ 
                          Clipboard.setData(ClipboardData(text: typing.text));
                        }, 
                        style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Text("Copy Text")
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
