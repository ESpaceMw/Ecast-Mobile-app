import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class ViewPodcast extends StatelessWidget {
  final dynamic details;
  const ViewPodcast({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.5),
                    bottomRight: Radius.circular(5.5),
                  ),
                ),
                child: ShaderMask(
                  shaderCallback: (rect) => const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black87,
                      kBackgroundColor,
                    ],
                  ).createShader(rect),
                  blendMode: BlendMode.overlay,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.47,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_7.jpg'),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black45, BlendMode.lighten),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: const Icon(
                        Icons.menu_book_sharp,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * 0.5,
                    imageUrl: details['cover_art'],
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: btnColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.4,
                left: MediaQuery.of(context).size.width * 0.18,
                child: Text(
                  details['title'],
                  style: titleStyles,
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.445,
                left: MediaQuery.of(context).size.width * 0.334,
                child: Text(
                  details['author'],
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              details['description'],
              style: infostyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "153 listeners",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "130 episodes",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Icon(Icons.feed_sharp),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(
                        20.8,
                      ),
                    ),
                    child: const Text(
                      "Subscribe",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(Icons.share)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 8, 10, 10),
            child: Text(
              'All episodes',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
