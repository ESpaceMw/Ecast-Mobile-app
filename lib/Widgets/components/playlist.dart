import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/Errors/httpex.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/Widgets/components/playlistinput.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Repository repo = Repository(networkService: NetworkService());

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).playlist();
    final size = MediaQuery.of(context).size;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is FetchedPlaylist) {
          if (state.playlist.isEmpty) {
            return Container(
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have No Playlist'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height,
                    child: ListView(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, playlistInput);
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
                              child: const Text(
                                'Create Playlist',
                                style: info,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('playlists');
          }
        } else {
          if (state is FetchingPlaylist) {
            return Container(
              height: size.height,
              child: const Center(
                child: CircularProgressIndicator(
                  color: btnColor,
                ),
              ),
            );
          } else if (state is NetError) {
            return SocketErr(msg: state.msg);
          } else {
            return const HttpExc(msg: "Server Error! Contact System Admin");
          }
        }
      },
    );
  }
}

// class EmptyScreen extends StatelessWidget {
//   const EmptyScreen({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;
  

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
