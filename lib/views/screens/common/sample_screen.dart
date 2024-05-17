import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/methods.dart';
import '../../../utils/values.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => SampleScreenState();
}

class SampleScreenState extends State<SampleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    putLazyCommon();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(bgcolor),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('GetX Demonstration'),
          actions: [
            IconButton(onPressed: cc.increment, icon: const Icon(Icons.add)),
            IconButton(onPressed: cc.decrement, icon: const Icon(Icons.remove))
          ],
        ),
        body: Obx(
          () => Column(children: <Widget>[
            Text(cc.count.string),
            AnimatedContainer(
              height: (10 * cc.count.value).toDouble(),
              duration: const Duration(seconds: 2),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green, Colors.blue])),
            ),
            // Expanded(
            //     child: SingleChildScrollView(
            //         padding: EdgeInsets.symmetric(horizontal: context.width / 40),
            //         child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               SizedBox(
            //                 height: 30,
            //               )
            //             ])))
          ]),
        ));
  }
}
