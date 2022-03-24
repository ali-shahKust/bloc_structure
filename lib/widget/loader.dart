import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoaderIndicator extends StatefulWidget {
  const LoaderIndicator({Key? key}) : super(key: key);

  @override
  State<LoaderIndicator> createState() => _LoaderIndicatorState();
}

class _LoaderIndicatorState extends State<LoaderIndicator> {
  @override
  Widget build(BuildContext context) {
    return const SpinKitDoubleBounce(
      color: Colors.white,
    );
  }
}
