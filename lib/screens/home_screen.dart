import 'package:flutter/material.dart';
import 'package:mind_matters/screens/forum_screen.dart';
import 'package:mind_matters/component/add_post.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selected_index=0;
  void _onItemTapped(int index) {
    setState(() {
      _selected_index = index;
   

    });
  }
 
  final List<Widget> _pages = [
    Rooms(),
    Container(
      color: Color.fromRGBO(175, 200, 173, 1),
      child: Text("Search"),
    ),
    Container(
      child: Text("Chat"),
    ),
    Container(
      child: Text("Profile"),
    ),
    AddPost()
  ];
  
  @override
  Widget build(BuildContext context) {
    
 
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Mind Matter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: _pages[_selected_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selected_index,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
