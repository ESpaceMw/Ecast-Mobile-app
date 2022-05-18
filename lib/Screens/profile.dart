import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final dynamic details;

  const Profile({Key? key, required this.details}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const FaIcon(
                FontAwesomeIcons.angleLeft,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: size.height * 0.1,
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
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
                  bottom: 0.0,
                  left: size.width * 0.3,
                  child: Image.asset(
                    'assets/logos/user.png',
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                        top: 10.0,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        // size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 30,
              // ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.details['first_name'],
                    style: textStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.details['last_name'],
                    style: textStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.details['email'],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: kBackgroundColor,
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: size.height * 0.9,
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: whiteColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  child: const Text(
                    'Edit profile',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
