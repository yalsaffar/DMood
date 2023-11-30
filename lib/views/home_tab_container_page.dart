import 'package:flutter/material.dart';
import 'package:dmood/views/home_page.dart';


class HomeTabContainerPage extends StatefulWidget {
  const HomeTabContainerPage({Key? key}) : super(key: key);

  @override
  HomeTabContainerPageState createState() => HomeTabContainerPageState();
}

class HomeTabContainerPageState extends State<HomeTabContainerPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTabview(),
            Expanded(
              child: TabBarView(
                controller: tabviewController,
                children: [
                  HomePage(),
                  HomePage(),
                  HomePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: TextField(
        decoration: InputDecoration(
          hintText: "Search",
        ),
        controller: searchController,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTabview() {
    return Container(
      height: 50,
      color: Colors.white,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            child: Text("Popular"),
          ),
          Tab(
            child: Text("Trending"),
          ),
          Tab(
            child: Text("Following"),
          ),
        ],
      ),
    );
  }
}