import 'package:application/models/play_result_model.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final PlayResultModel playResultInstance;

  const ResultScreen({
    super.key,
    required this.playResultInstance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // title: Center(
        //   child: IconButton(
        //     onPressed: () => onPressedButton(context),
        //     icon:
        //         Icon(isRecording ? Icons.stop_circle : Icons.play_circle_fill),
        //     color: Colors.white,
        //     iconSize: 50,
        //   ),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < 3; i++)
            // for (var j = 0; j < 4; j++)
            SheetLinePerComponent(
              playResultInstance: playResultInstance,
              i: i,
              // j: j,
            ),
        ],
      ),
    );
  }
}

class SheetLinePerComponent extends StatelessWidget {
  final int i;
  const SheetLinePerComponent({
    super.key,
    required this.playResultInstance,
    required this.i,
  });

  final PlayResultModel playResultInstance;

  @override
  Widget build(BuildContext context) {
    // print('$i $j');
    // print(playResultInstance.sheet[i][j].map((v) => v ? 1 : 0).toList());
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          for (var j = 0; j < 4; j++) Row(children: makeLine(j)),
        ],
      ),
    );
  }

  List<Widget> makeLine(int j) {
    var label = ['CC', 'HH', 'SD', 'KK'];

    List<Widget> line = [
      Text(
        label[j],
        style: const TextStyle(fontSize: 20),
      ),
      const SizedBox(width: 20),
    ];
    for (var idx = 0; idx < 16 * 3; idx++) {
      if (idx % 16 == 0) {
        line.add(const SizedBox(width: 10));
      }
      line.add(Icon(
        playResultInstance.sheet[i][j][idx] == true
            ? Icons.circle
            : Icons.circle_outlined,
        size: 20,
      ));
    }
    return line;
  }
}
