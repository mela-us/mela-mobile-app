import 'package:flutter/material.dart';
import 'package:math_keyboard/math_keyboard.dart';

class MathKeyboardScreen extends StatefulWidget {
  @override
  _MathKeyboardScreenState createState() => _MathKeyboardScreenState();
}

class _MathKeyboardScreenState extends State<MathKeyboardScreen> {
  final TextEditingController _textController = TextEditingController();
  final MathFieldEditingController _mathController = MathFieldEditingController();
  bool _isMathKeyboardVisible = false;

  void _toggleMathKeyboard() {
    setState(() {
      if (_isMathKeyboardVisible && _mathController.currentEditingValue().toString() != '\\Box') {
        // Khi đóng math keyboard, chèn nội dung vào vị trí con trỏ của text field
        int cursorPos = _textController.selection.baseOffset;
        String currentText = _textController.text;
        String mathValue = _mathController.currentEditingValue();

        if (cursorPos < 0 || cursorPos > currentText.length) {
          cursorPos = currentText.length;
        }

        String newText = currentText.substring(0, cursorPos) +
            mathValue +
            currentText.substring(cursorPos);

        _textController.text = newText;
        _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorPos + mathValue.length),
        );
      }
      _isMathKeyboardVisible = !_isMathKeyboardVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Math Keyboard Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_isMathKeyboardVisible)
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Text or Math Expression',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calculate),
                    onPressed: _toggleMathKeyboard,
                  ),
                ),
                readOnly: false,
              ),
            if (_isMathKeyboardVisible)
              MathField(
                controller: _mathController,
                keyboardType: MathKeyboardType.expression,
                variables: ['x', 'y', 'z'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nhập liệu toán học',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: _toggleMathKeyboard,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}