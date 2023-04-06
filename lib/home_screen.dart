import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/API.dart';
import 'package:wallpaper/wall_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _Pageno = 0;
  String _vector = "all";
  String _order = "popular";
  String _latest = "popular";
  String _illstration = "all";
  String _image_type = "all";
  String _subject = "";
  bool _editor_choice = false;
  String _orientation = "";
  List<String> ImageList = [];
  bool isLoading = false;

  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    _fetch();
    _scrollController.addListener(_scroll);
    super.initState();
  }

  Future<void> _refresh() async {
    _Pageno = 1;
    ImageList.clear();
    final d = await Provider.of<API>(context, listen: false).fetchData(
        subject: _subject,
        order: _order,
        image_type: _image_type,
        pageno: _Pageno,
        orientation: _orientation,
        editor_choice: _editor_choice);

    setState(() {
      ImageList.addAll(d);
    });
  }

  Future<void> _fetch() async {
    _Pageno++;
    final d = await Provider.of<API>(context, listen: false).fetchData(
        subject: _subject,
        pageno: _Pageno,
        order: _order,
        image_type: _image_type,
        orientation: _orientation,
        editor_choice: _editor_choice);

    setState(() {
      ImageList.addAll(d);
    });
  }

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetch();
    }
  }

  void _search(String subject) async {
    _Pageno = 1;
    setState(() {
      ImageList.clear();
    });

    _subject = subject;
    final list = await Provider.of<API>(context, listen: false).fetchData(
        subject: _subject,
        order: _order,
        editor_choice: _editor_choice,
        image_type: _image_type);

    setState(() {
      ImageList.addAll(list);
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _scrollController.dispose();
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 10,
                      child: TextField(
                        onSubmitted: (value) {
                          if (_textController.text.isNotEmpty) {
                            _search(_textController.text);
                          } else {
                            setState(() {
                              _subject = "";
                            });
                          }
                        },
                        controller: _textController,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search_rounded),
                            label: Text(
                              "Search",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            hintStyle: Theme.of(context).textTheme.titleMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    )),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ChoiceChip(
                            backgroundColor: Colors.orange,
                            selectedColor: Colors.red,
                            onSelected: (bool selected) {
                              setState(() {
                                _vector = (selected) ? "vector" : "all";
                                _image_type = _vector;
                                _Pageno = 0;
                                ImageList.clear();
                                _fetch();
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            label: const Text("Vector"),
                            selected: _vector != "all",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ChoiceChip(
                            backgroundColor: Colors.orange,
                            selectedColor: Colors.red,
                            onSelected: (bool selected2) {
                              setState(() {
                                _illstration =
                                    (selected2) ? "illustration" : "all";
                                _image_type = _illstration;
                                _Pageno = 0;
                                ImageList.clear();
                                _fetch();
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            label: const Text("Illustration"),
                            selected: _illstration != "all",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ChoiceChip(
                            selectedColor: Colors.red,
                            onSelected: (bool selected) {
                              setState(() {
                                _latest = (selected) ? "latest" : "popular";
                                _order = _latest;
                                _Pageno = 0;
                                ImageList.clear();
                                _fetch();
                              });
                            },
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            label: const Text("Latest"),
                            selected: _latest == "latest",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ChoiceChip(
                            selectedColor: Colors.red,
                            backgroundColor: Colors.orange,
                            onSelected: (bool selected) {
                              setState(() {
                                _editor_choice = (selected) ? true : false;
                                ImageList.clear();
                                _Pageno = 0;
                                _fetch();
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            label: const Text("Editor Choice"),
                            selected: _editor_choice,
                          ),
                        ),
                      ]),
                ),
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () => _refresh(),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    child: (ImageList.isEmpty)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MasonryGridView.builder(
                            controller: _scrollController,
                            itemCount: ImageList.length + 1,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    WallScreen.wall_screen,
                                    arguments: ImageList[index]);
                              },
                              child: (ImageList.length > index)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          filterQuality: FilterQuality.low,
                                          ImageList[index],
                                          fit: BoxFit.cover))
                                  : const SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                            ),
                          ),
                  ),
                ))
              ],
            )));
  }
}
