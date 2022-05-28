import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is PlaylistCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Playlist Created Successfully"),
                ),
              );
              Navigator.pop(context);
              BlocProvider.of<UserCubit>(context).playlist();
            }
          },
          builder: (context, state) {
            if (state is CreatingPlaylist) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Creating Your Playlist",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CircularProgressIndicator(
                    color: btnColor,
                  ),
                ],
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: playlistName,
                          validator: (title) {
                            if (title == '') {
                              return 'Please input the playlist title';
                            }
                            return null;
                          },
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
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // final form = _formkey.currentState;
                            // if (form != null && form.validate()) {
                            BlocProvider.of<UserCubit>(context).newPlaylist();
                            // }
                          },
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
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    ));
  }
}
