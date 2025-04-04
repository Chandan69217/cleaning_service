import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;
  final Color? borderColor;

  const CounterButton({Key? key, this.initialValue = 0, this.onChanged,this.borderColor}) : super(key: key);

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    widget.onChanged?.call(_counter);
  }

  void _decrement() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
      widget.onChanged?.call(_counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenWidth * 0.09,
      width: screenWidth * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.015),
        border: Border.all(color: widget.borderColor??Colors.indigoAccent),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Minus Button
          Flexible(
            fit: FlexFit.loose,
            child: FittedBox(
              fit: BoxFit.contain,
              child: IconButton(
                onPressed: _decrement,
                style: IconButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                icon: Icon(Icons.remove),
                color: Colors.black,
              ),
            ),
          ),
          // Counter Display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: (screenWidth * 0.09) * 0.4, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Plus Button
          Flexible(
            fit: FlexFit.loose,
            child: FittedBox(
              fit: BoxFit.contain,
              child: IconButton(
                onPressed: _increment,
                style: IconButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                icon: Icon(Icons.add),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
