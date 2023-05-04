import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
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
  PageController indicator = PageController();
  int page = 0;

  @override
  void initState() {
    super.initState();
    indicator.addListener(() {
      setState(() {
        page = indicator.page!.round();
      });
    });
  }

  Widget circleIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (page >= 1)
            IconButton(
              onPressed: () {
                indicator.animateToPage(
                  indicator.page!.round() - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.arrow_left,
                color: Colors.white,
              ),
            ),
          
          for (int i = 0; i < widget.listSlideShow.length; i++)
            IconButton(
              
              onPressed: () {
                indicator.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),

              icon: Icon(
                Icons.circle,
                color: page == i ? Colors.white : Colors.grey,
                size: 10,
              ),
            ),
          
          if (page < widget.listSlideShow.length - 1)
            IconButton(
              onPressed: () {
                indicator.animateToPage(
                  indicator.page!.round() + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.arrow_right,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget slideShow() {
    return PageView.builder(
      controller: indicator,
      itemCount: widget.listSlideShow.length,

      onPageChanged: (value) {
        setState(() {
          page = value;
          indicator.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        });
      },
      itemBuilder: (context, index) {
        
        return  ElevatedButton(
            onPressed: () {
              Navigator.push(context, navigator('products', widget.listSlideShow[index]));
              widget.listSlideShow[index].onTap;
            },

            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: Container(
              
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.listSlideShow[index].path,
                  ),
                  opacity: 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 60),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (page >= 1) ?
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_left,
                                size: 30,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                indicator.animateToPage(
                                  indicator.page!.round() - 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                            ) : const SizedBox(),

                          if (page < widget.listSlideShow.length - 1)
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_right,
                                size: 30,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                indicator.animateToPage(
                                  indicator.page!.round() + 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.listSlideShow[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
    
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          slideShow(),
          circleIndicator(),
        ],
      ),
    );
  }
}