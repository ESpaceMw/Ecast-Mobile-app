import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: size.height * 0.06,
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ob.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black45,
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.3,
                    bottom: size.width * 0.25,
                    child: const Text(
                      'Free Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          bottom: 5.0, left: 20, right: 10, top: 20),
                      child: Text(
                        'Why join Premium?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[850],
                      thickness: 0.6,
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: reslits,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              CarouselSlider(
                items: plandetails,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 1.5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    // TODO: link to site
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Text(
                      'Upgrade Subscription',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
