import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State createState() {
    return _AnimatedListScreenState();
  }
}

/// AnimatedList
/// List에 item 추가/삭제에 애니메이션 효과를 추가한 위젯
/// AnimatedListState를 GlobalKey로 만들어서 접근하여 추가/삭제
/// AnimatedListState는 AnimatedList의 상태를 관리,
/// insertItem에서는 아이템이 추가될 위치만 받음
/// removeItem에서는 AnimatedRemovedItemBuilder를 통해서 삭제 Transition을 구현
class _AnimatedListScreenState extends State<AnimatedListScreen> {

  int idx = 0;
  // AnimatedList를 handling 하기 위한 key
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> myList = [];

  void addItem() {
    setState(() {
      myList.insert(0, "New Item ${idx++}");
      _listKey.currentState?.insertItem(0);
    });
  }

  void removeItem(String item) {
    setState(() {
      final index = myList.indexOf(item);
      _listKey.currentState?.removeItem(index, (context, animation) {
        return ScaleTransition(
          scale: animation,
          child: ListTile(
            title: Text(item),
          ),
        );
        return FadeTransition(
          opacity: animation,
          child: ListTile(
            title: Text(item),
          ),
        );
      },);
      myList.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated List"),
      ),
      body: AnimatedList(
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ListTile(
              title: Text(myList[index]),
              trailing: IconButton(
                onPressed: () {
                  removeItem(myList[index]);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}