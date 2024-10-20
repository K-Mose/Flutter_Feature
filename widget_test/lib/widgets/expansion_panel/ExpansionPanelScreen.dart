import 'package:flutter/material.dart';

/// ExpansionPanel은 확장 가능한
///
class ExpansionPanelScreen extends StatefulWidget {
  const ExpansionPanelScreen({super.key});
  @override
  State createState() => _ExpansionPanelState();
}

class _ExpansionPanelState extends State<ExpansionPanelScreen> {
  List<bool> expandedList = [false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("ExpansionPanel"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                print(isExpanded);
                return const Text("Header 1");
              },
              body: const Text("body 1 opened"),
              isExpanded: expandedList[0]
            ),
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                print(isExpanded);
                return const Text("Header 2");
              },
              body: const Text("body 2 opened"),
              isExpanded: expandedList[1]
            ),
          ],
          expansionCallback: (i, isExpanded) {
            // i: 콜백 호출한 panel의 index
            print("$i // $isExpanded");
            setState(() {
              expandedList[i] = !isExpanded;
            });
          },
        )
      ),
    );
  }
}