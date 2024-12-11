import 'package:flutter/material.dart';

class PerguntaLogin extends StatefulWidget {
  final Color cor;
  final void Function(String) onValueChanged;
  final String labelText; // New parameter for custom label text

  const PerguntaLogin({
    Key? key,
    required this.cor,
    required this.onValueChanged,
    required this.labelText, // Added required parameter
  }) : super(key: key);

  @override
  _PerguntaLoginState createState() => _PerguntaLoginState();
}

class _PerguntaLoginState extends State<PerguntaLogin> {
  String userEMailCpf = "";
  late Color corAtual;

  @override
  void initState() {
    super.initState();
    corAtual = widget.cor;
  }

  @override
  void didUpdateWidget(PerguntaLogin oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cor != widget.cor) {
      setState(() {
        corAtual = widget.cor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.labelText, // Using the custom label text
        labelStyle: TextStyle(color: corAtual),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: corAtual, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: corAtual, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: corAtual),
        ),
      ),
      style: TextStyle(color: corAtual),
      cursorColor: corAtual,
      onChanged: (value) {
        setState(() {
          userEMailCpf = value;
          widget.onValueChanged(value);
        });
      },
    );
  }
}