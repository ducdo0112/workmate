import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({
    Key? key,
    this.action,
  }) : super(key: key);
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                S.current.notice,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.blackOlive,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                S.current.no_connection_message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackOlive,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 20, top: 20),
                  child: Text(
                    S.current.ok,
                    style: const TextStyle(color: AppColor.yellowOrange),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
