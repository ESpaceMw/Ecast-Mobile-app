import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/podcastcat.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/Errors/httpex.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/Widgets/components/indicator.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Repository repo = Repository(networkService: NetworkService());

class GenresList extends StatelessWidget {
  const GenresList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).categories();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'All Genres',
                  style: textStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
              if (state is FetchedCat) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.3),
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: SearchCubit(repository: repo),
                              child: FilterPodcasts(
                                category: state.categories[index]['name'],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0.5),
                                ],
                              ).createShader(rect),
                              blendMode: BlendMode.darken,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    width: size.width * 0.4,
                                    imageUrl: state.categories[index]
                                        ['cover_art'],
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: btnColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: size.width * 0.1,
                              bottom: size.width * 0.4,
                              child: Text(
                                state.categories[index]['name'],
                                style: textStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                if (state is HttpErr) {
                  return const HttpExc(
                      msg: "Server Error! Contact system Admin");
                } else if (state is SocketErr) {
                  return const SocketErr(
                      msg: "Network Error! Check Your Connection");
                } else {
                  return const CirculaIndicator();
                }
              }
            })
          ],
        ),
      ),
    );
  }
}
