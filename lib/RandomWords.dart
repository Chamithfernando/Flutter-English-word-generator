import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();

}

class _RandomWordsState extends State<RandomWords> {

  final _randomWordPair = <WordPair>[]; // it describes word pair list
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, item){
        if(item.isOdd) return Divider();

        final index = item ~/ 2;

        if(index >= _randomWordPair.length){
          _randomWordPair.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPair[index]);

      },
    );
  }

  Widget _buildRow(WordPair pair){

    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase,
        style: TextStyle(fontSize: 18.0,
          fontWeight: FontWeight.normal,
        ),
      ),

      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
      ),

      onTap: (){
        setState(() {
          if(alreadySaved){
            _savedWordPairs.remove(pair);
          }else{
            _savedWordPairs.add(pair);
          }

        });
      },
    );
  }


  void _pushSaved(){
    Navigator.of(context)
        .push(
          MaterialPageRoute(
              builder: (BuildContext context){
                final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );

                  
            });
            
            final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text('Saved WordPairs'),
              ),

              body: ListView(children: divided),
            );
          }
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next,
            size: 35.0,
              color: Colors.white,
            ),
            onPressed: _pushSaved,
          ),
        ]
      ),
      body: _buildList(),
    );
  }
}
