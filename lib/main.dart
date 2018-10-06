import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return new MaterialApp(
      title: 'Startup Name Generator', //'Welcome to Flutter',
      theme:new ThemeData.dark(),
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
class RandomWordsState extends State<RandomWords> {
  @override
  //saves suggested word pairings
  final List<WordPair> _suggestions =
      <WordPair>[]; //final _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(
      fontSize: 18.0); //final _biggerFont = const TextStyle(fontSize:18.0);
  final Set<WordPair> _saved = new Set<WordPair>();

  Widget _buildSuggestion() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        //itemBuidler callback function is called once per suggested word pairing,
        //and places each suggestion into a listtile row.
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/
              2; //"i~/2"divides i by 2 and returns an integer result, 1,2,3,4,5 becomes 0.1.1.2.2
          //this calculates the actual number of word pairings in the list view.
          //minus the divider widgets
          if (index >= _suggestions.length) {
            //if reaching the end of the available word pairings,
            //then generate 10 more and add them to the suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(
        pair); //to ensure that a word pairing has not already been added to favs.
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.accessible_forward : Icons.accessible,
        //alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: new AppBar(
          title: new Text('Startup Name Generator'),
          actions: <Widget>[
            //some widget properties like action, take an array of widgets(children), as indicated by the square bracket([])
            //add a list icon to the app bar.
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ]),
      body: _buildSuggestion(),
    );
  }

  void _pushSaved() {
    //push a new page into the stack.
    Navigator.of(context).push(new MaterialPageRoute<void>(
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        //The divideTiles() method of ListTile adds horizontal spacing between each ListTile.
        //The divided variable holds the final rows,
        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        //The body of the new route consists of a ListView containing the ListTiles rows;
        // each row is separated by a divider.
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      },
    ));
  }
}

//only creates its state class
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
