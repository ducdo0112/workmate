import 'package:workmate/model/enum/bloc_status.dart';
import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  final BlocStatus loadStatus;
  final String title;
  final VoidCallback buttonClick;
  final Color backgroundColor;
  final double radiusBorder;
  final double heightButton;

  const ButtonLoading({
    Key? key,
    required this.loadStatus,
    required this.title,
    required this.buttonClick,
    this.backgroundColor = Colors.red,
    this.radiusBorder = 4.0,
    this.heightButton = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        buttonClick.call();
      },
      child: loadStatus == BlocStatus.loading
          ? SizedBox(
              width: double.infinity,
              height: heightButton,
              child: const SizedBox(
                height: 18,
                width: 18,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : Container(
              child: Center(
                child: Text(title),
              ),
            ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusBorder),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          fixedSize:
              MaterialStateProperty.all(Size(double.infinity, heightButton))),
    );
  }
}
