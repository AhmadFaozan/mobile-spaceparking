import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginlagi/pages/detail.dart';

class Artikel extends StatefulWidget {
  @override
  _ArtikelState createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  
  List _posts = [];


  @override
  void initState(){
    super.initState();
    _getData();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              color: Colors.grey[200],
              height: 100,
              width: 100,
              child: _posts[index]['urlToImage'] != null ?
              Image.network(_posts[index]['urlToImage'], width:100, fit: BoxFit.cover,) : Center(),
            ),
            title: Text('${_posts[index]['title']}', maxLines:2,overflow:TextOverflow.ellipsis,),
            subtitle: Text('${_posts[index]['description']}', maxLines:2, overflow:TextOverflow.ellipsis,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c) => Detail(
                url: _posts[index]['url'],
                title: _posts[index]['title'],
                content: _posts[index]['content'],
                publishedAt: _posts[index]['publishedAt'],
                author: _posts[index]['author'],
                urlToImage: _posts[index]['urlToImage'],

              ),
              ),
              );
            },
          );

        },
      ),
    );
  }

  Future _getData() async{
    try {
      final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=id&apiKey=053e1159c58a4bc4972a9f3a99ff1666'));
     
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        print(data);
        setState(() {
          _posts = data['articles'];
        });
      }
    } catch (e) {
        print(e);
      
    }
  }
}
   
