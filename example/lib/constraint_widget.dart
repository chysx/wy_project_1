import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customer_align.dart';

class ConstraintWidget extends StatelessWidget {
  const ConstraintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("constraint widget"),
      ),
      body: Container(
        color: Colors.yellow,
        width: 200,
        height: 200,
        child: CustomerAlign(
          alignment: Alignment.center,
          child: Container(
            color: Colors.red,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
