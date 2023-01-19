import 'package:flutter/material.dart';
import 'package:origin/resources/color_manager.dart';

class LoadingProgressIndicator extends StatefulWidget {
  final Function? ontap;

  const LoadingProgressIndicator({Key? key, this.ontap}) : super(key: key);

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<LoadingProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      alignment: Alignment.center,
      child:  CircularProgressIndicator(
        color: ColorManager.darkPrimary,
      ),
    );
  }
}
