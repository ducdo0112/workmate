import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workmate/common/color/app_color.dart';

import '../../../account_info/widget/profile_widget.dart';
import '../../../add_chat_group/widget/profile_widget_chat.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final String avatar;
  final String email;
  final bool isSameSenderBefore;
  final bool isPrivateChat;
  final String status;
  final int timeSendMessage;

  const MessageTile({
    Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe,
    required this.avatar,
    required this.email,
    required this.isSameSenderBefore,
    required this.status,
    required this.isPrivateChat,
    required this.timeSendMessage,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            widget.sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 4,
                bottom: 4,
                left: widget.sentByMe ? 0 : 16,
                right: widget.sentByMe ? 16 : 0),
            alignment:
                widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: widget.sentByMe
                  ? const EdgeInsets.only(left: 16)
                  : const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.only(
                  top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: widget.sentByMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                color: widget.sentByMe ? AppColor.orangePeel : Colors.black12.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: !widget.isPrivateChat,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.sender.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !widget.isPrivateChat,
                    child: const SizedBox(
                      height: 8,
                    ),
                  ),
                  Text(
                    widget.message,
                    textAlign:
                        widget.sentByMe ? TextAlign.right : TextAlign.left,
                    style:  TextStyle(fontSize: 14, color:  widget.sentByMe ? Colors.white: Colors.black),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: widget.sentByMe ? 0 : 16,
                  right: widget.sentByMe ? 16 : 0),
              child: Text(
                _getTimeDisplay(widget.timeSendMessage),
                style: const TextStyle(fontSize: 8, color: AppColor.textColorSilver),
              ))
        ],
      ),
    );
  }

  _getTimeDisplay(int time) {
    try {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);

      // Format the DateTime object
      return DateFormat('hh:mm').format(dateTime);
    } catch (_) {
      return "";
    }
  }

  _buildChatMessageByMe() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: widget.sentByMe
                ? const EdgeInsets.only(left: 30)
                : const EdgeInsets.only(right: 30),
            padding:
                const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: widget.sentByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
              color: widget.sentByMe ? AppColor.orangePeel : Colors.grey,
            ),
            child: Text(
              widget.message,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 100,
              softWrap: true,
            ))
      ],
    );
  }

  _buildChatMessageByOther() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: widget.isSameSenderBefore
              ? SizedBox()
              : ProfileWidgetChat(
                  imageBase64: widget.avatar,
                ),
        ),
        Container(
          margin: widget.sentByMe
              ? const EdgeInsets.only(left: 30)
              : const EdgeInsets.only(right: 30),
          padding:
              const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: widget.sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                  ),
            color: widget.sentByMe ? AppColor.lightGray : AppColor.gainsBoro,
          ),
          child: Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            maxLines: 100,
          ),
        ),
      ],
    );
  }
}
