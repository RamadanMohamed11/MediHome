import 'package:flutter/material.dart';
import 'package:medihome/core/utils/assets_data.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: Image.asset(
          AssetsData.loading,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
    );
  }
}
