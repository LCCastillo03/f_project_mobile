
import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final void onPressedAction;

  const FloatingAddButton({super.key, required this.onPressedAction});

  @override
  Widget build(BuildContext context) {
    return Positioned( 
      bottom: 20, 
      right: 20, 
      child: Container( 
        decoration: BoxDecoration( 
          color: Colors.white, 
          borderRadius: const BorderRadius.all(Radius.circular(20)), 
          boxShadow: [ 
            BoxShadow( 
              color: Colors.black26, 
              blurRadius: 10, 
              spreadRadius: 2, 
            ), 
          ], 
        ), 
        padding: EdgeInsets.all(6), 
        child: IconButton( 
          icon: Icon( 
            Icons.add, 
            size: 30,
          ), 
          onPressed: () => onPressedAction,
        ), 
      ), 
    );
  }

}