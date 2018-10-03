import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',//'Welcome to Flutter',
      home: RandomWords(),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome to Flutter'),
//        ),
//        body: Center(
//          //child: Text('Hello World'),
//          //child:Text(wordPair.asPascalCase),
//          child: RandomWords(),
//        ),
//      ),
    );
  }
}

//this class saves the generated word pairs//user chosen words, basically save anything appears?
class RandomWordsState extends State<RandomWords>{
  @override
  final _suggestions = <WordPair>[];//saves suggested word pairings
  final _biggerFont = const TextStyle(fontSize:18.0);

  Widget _buildSuggestion(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      //itemBuidler callback function is called once per suggested word pairing,
        //and places each suggestion into a listtile row.
      itemBuilder: (context,i){
        if(i.isOdd)return Divider();

        final index = i~/2;//"i~/2"divides i by 2 and returns an integer result, 1,2,3,4,5 becomes 0.1.1.2.2
        //this calculates the actual number of word pairings in the list view.
        //minus the divider widgets
        if(index >= _suggestions.length){
          //if reaching the end of the available word pairings,
          //then generate 10 more and add them to the suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){
    return ListTile(
      title:Text(
        pair.asPascalCase,
        style: _biggerFont,
      )
    );
  }

  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestion(),
    );
  }
}

//only creates its state class
class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState()=>new RandomWordsState();
}