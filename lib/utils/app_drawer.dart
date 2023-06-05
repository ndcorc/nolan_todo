import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<SliderDrawerState> _drawerKey = GlobalKey<SliderDrawerState>();

class AppDrawer extends StatelessWidget {
  const AppDrawer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliderDrawer(
      key: _drawerKey,
      appBar: const SliderAppBar(
        appBarHeight: 115,
        appBarColor: Colors.blueGrey,
        appBarPadding: EdgeInsets.only(top: 48),
        drawerIconColor: Colors.white,
        title: Text(
          "App Bar",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      slider: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                  _drawerKey.currentState!.closeSlider();
                },
                child: const Text("SimpleTodo"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/details');
                  _drawerKey.currentState!.closeSlider();
                },
                child: const Text("Details"),
              )
            ],
          ),
        ),
      ),
      child: child,
    );
  }
}
