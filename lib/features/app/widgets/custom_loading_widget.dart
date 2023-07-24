import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  final bool isError;
  final double size;
  const CustomLoadingWidget({
    super.key,
    this.isError = false,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Lottie.asset('assets/lotties/loading.json'),
      child: SizedBox(
        height: size,
        width: size,
        child: RepaintBoundary(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: isError ? Colors.red : null,
          ),
        ),
      ),
    );
  }
}
