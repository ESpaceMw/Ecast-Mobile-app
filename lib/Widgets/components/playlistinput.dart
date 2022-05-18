import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class PlaylistInput extends StatelessWidget {
  const PlaylistInput({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  get playlistName => null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: playlistName,
                decoration: const InputDecoration(
                  hintText: "Playlist title",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: whiteColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: btnColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
