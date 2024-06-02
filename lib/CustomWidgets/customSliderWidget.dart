import 'package:flutter/material.dart';

class QuantityInputSlider extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final ValueChanged<int>? onChanged;

  const QuantityInputSlider({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _QuantityInputSliderState createState() => _QuantityInputSliderState();
}

class _QuantityInputSliderState extends State<QuantityInputSlider> {
  late TextEditingController _textEditingController;
  late int _value;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue.toString());
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textEditingController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _value = int.tryParse(value) ?? 0;
              if (_value < widget.minValue) {
                _value = widget.minValue;
                _textEditingController.text = widget.minValue.toString();
              } else if (_value > widget.maxValue) {
                _value = widget.maxValue;
                _textEditingController.text = widget.maxValue.toString();
              }
              widget.onChanged?.call(_value);
            });
          },
        ),
        SizedBox(height: 8.0),
        Slider(
          value: _value.toDouble(),
          min: widget.minValue.toDouble(),
          max: widget.maxValue.toDouble(),
          onChanged: (value) {
            setState(() {
              _value = value.toInt();
              _textEditingController.text = value.toStringAsFixed(0);
              widget.onChanged?.call(_value);
            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
