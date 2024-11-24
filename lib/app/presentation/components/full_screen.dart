import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

class FullScreen extends StatelessWidget {
  final String image;
  const FullScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          /*Hero(
            tag: image,
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) =>
                  const Image(image: AssetImage('assets/gif/animc.gif')),
              errorWidget: (context, url, error) =>
                  const Image(image: AssetImage('assets/images/noimage.png')),
            ),
          ),*/
          Positioned(
            top: 60,
            right: 10,
            child: CircleAvatar(
              backgroundColor: textColor,
              child: Center(
                child: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
