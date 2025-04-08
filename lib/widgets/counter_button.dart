import 'package:flutter/material.dart';
import '../models/cart_items.dart';
import '../models/categories_service.dart';
import '../models/global_keys.dart';
import '../utilities/remove_cart_item.dart';
import '../utilities/update_cart_qty.dart';

class CounterButton extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;
  final Color? borderColor;
  final Service service;

  const CounterButton({Key? key, this.initialValue = 0, this.onChanged,this.borderColor,required this.service}) : super(key: key);

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  late int _counter;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _increment() async {
    setState(() {
      _isLoading = true;
    });

    int newCount = _counter + 1;
    var updatedCount = await _updateQty(newCount);

    if (updatedCount != null) {
      _counter = updatedCount;
      // await Keys.homeScreenKey.currentState!.refresh();
      widget.onChanged?.call(updatedCount);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _decrement() async {
    if (_counter == 0) return;
    setState(() {
      _isLoading = true;
    });

    int newCount = _counter - 1;

    if (newCount == 0) {
      var status = await removeCartItem(
        CartItemsList.cartIdByServiceId[widget.service.id].toString(),
      );

      if (status) {
        _counter = 0;
        // await Keys.homeScreenKey.currentState!.refresh();
        widget.onChanged?.call(0);
      }
    } else {

      var updatedCount = await _updateQty(newCount);

      if (updatedCount != null) {
        _counter = updatedCount;
        widget.onChanged?.call(updatedCount);
      }
    }

    setState(() {
      _isLoading = false;
    });
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
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
                  onPressed: _isLoading ? null: _decrement,
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
                  onPressed: _isLoading ? null:_increment,
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
          if(_isLoading)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: LinearProgressIndicator(
                  minHeight: 2,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                ),
              ),
            ),
        ]
      ),
    );
  }

  Future<int?> _updateQty(newValue)async{
    if(newValue < 1){
      var status = await removeCartItem(CartItemsList.cartIdByServiceId[widget.service.id].toString());
      if(status){
        Keys.homeScreenKey.currentState!.refresh();
        return 0;
      }
    }else{
      var status = await updateCartQty(cartId: CartItemsList.cartIdByServiceId[widget.service.id], qty: newValue);
      if(status){
        Keys.homeScreenKey.currentState!.refresh();
        return newValue;
      }
    }
  }

}
