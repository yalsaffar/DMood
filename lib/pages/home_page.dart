import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>, TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Assuming 3 tabs
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          // Add more AppBar properties as needed
        ),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Following'),
                Tab(text: 'Followers'),
                Tab(text: 'Suggested'),
              ],
              // make the tabs black
              labelColor: Colors.black,

            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent(), // Replace with actual content for each tab
                  _buildTabContent(),
                  _buildTabContent(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          // Custom BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              // Add an icon for a new post
              IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
              
            ],
          ),
        ),
        // Add FloatingActionButton if needed
      ),
    );
  }

  Widget _buildTabContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPostCard(context),
          _buildPostCard(context),
          _buildPostCard(context),
        ],
      ),
    );
  }
  Widget _buildPostCard(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              backgroundColor: Colors.transparent,
            ),
            title: Text("Bruno", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("1 hour ago"),
            trailing: Icon(Icons.more_vert),
          ),
          Image.network('https://via.placeholder.com/600x400', fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconText(Icons.add_circle_outline, "20"),
                _buildIconText(Icons.chat_bubble_outline, "125"),
                Icon(Icons.favorite_border),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
