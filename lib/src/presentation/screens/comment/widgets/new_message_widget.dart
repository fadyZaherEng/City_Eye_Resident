import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewMessageWidget extends StatefulWidget {
  final Function(String) onSend;
  final Function() onAttach;

  const NewMessageWidget({
    Key? key,
    required this.onSend,
    required this.onAttach,
  }) : super(key: key);

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            offset: Offset(5, 4),
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 0.13),
          )
        ],
      ),
      child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 24),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: S.of(context).typeYourMessage,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color.fromRGBO(161, 161, 161, 1)),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              // const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  widget.onAttach();
                },
                child: SvgPicture.asset(
                  ImagePaths.gallery,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              InkWell(
                onTap: () {
                  if (_messageController.text.toString().trim().isEmpty)
                    return;
                  widget.onSend(_messageController.text.toString().trim());
                  _messageController.clear();
                },
                child: SvgPicture.asset(
                  ImagePaths.sendMessage,
                  fit: BoxFit.scaleDown,
                  matchTextDirection: true,
                ),
              ),
            ],
          )),
    );
  }
}
