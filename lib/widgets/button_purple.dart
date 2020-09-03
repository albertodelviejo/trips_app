import 'package:flutter/material.dart';

class ButtonPurple extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final ValueNotifier<ButtonPurpleState> buttonStateChangeNotifier;

  ButtonPurple(
      {Key key,
      @required this.buttonText,
      @required this.onPressed,
      this.buttonStateChangeNotifier});

  @override
  _ButtonPurpleState createState() => _ButtonPurpleState();
}

enum ButtonPurpleState { enable, disable }

class _ButtonPurpleState extends State<ButtonPurple> {
  ButtonPurpleState _buttonPurpleState = ButtonPurpleState.enable;
  @override
  void initState() {
    super.initState();
    if (widget.buttonStateChangeNotifier != null) {
      widget.buttonStateChangeNotifier.addListener(_handleButtonStateChange);
      _buttonPurpleState = widget.buttonStateChangeNotifier.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _ButtonPurpleState == ButtonPurpleState.enable
          ? _handleOnPress
          : null,
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: 50.0,
        width: 180.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }

  _handleButtonStateChange() {
    setState(() {
      _buttonPurpleState = widget.buttonStateChangeNotifier.value;
    });
  }

  _handleOnPress() {
    if (_buttonPurpleState == ButtonPurpleState.enable) {
      widget.onPressed();
    }
  }
}
