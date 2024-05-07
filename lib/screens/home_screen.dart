import 'package:flutter/material.dart';
import 'package:mind_matters/screens/forum_screen.dart';
import 'package:mind_matters/component/add_post.dart';
import 'package:mind_matters/screens/search_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  var _selected_index = 0;
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  final List<Widget> _pages = [
    Rooms(),
    SearchScreen(),
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
    return _isLoading
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: Center(child: Image.asset('assets/main-logo.png'),),
            
          )
        : Scaffold(
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile")
              ],
            ),
          );
  }
}
