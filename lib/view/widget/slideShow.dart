import 'package:flutter/material.dart';
import 'package:tcc/model/standardSlideShow.dart';

class SlideShowWidget extends StatefulWidget {
  final List<SlideShow> listSlideShow;

  const SlideShowWidget({
    super.key,
    required this.listSlideShow,
  });

  @override
  State<SlideShowWidget> createState() => _SlideShowWidgetState();
}

class _SlideShowWidgetState extends State<SlideShowWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: PageView(
        children: [
          for (int i = 0; i < widget.listSlideShow.length; i++)
            ElevatedButton(
              onPressed: widget.listSlideShow[i].onTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Container(
                
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(
                      widget.listSlideShow[i].path,
                    ),
                    opacity: 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.listSlideShow[i].title,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}