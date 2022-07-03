import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Screens/view_subs.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/Errors/httpex.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/Widgets/components/indicator.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Repository repository = Repository(networkService: NetworkService());

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).subScription();

    return BlocConsumer<PodcastsCubit, PodcastsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PodcastsLoaded) {
          if (state.subs.isEmpty) {
            // ignore: sized_box_for_whitespace
            return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const Center(
                    child: Text(
                  "No subscriptions available",
                  style: textStyle,
                )));
          } else if (state is NetError) {
            return const SocketErr(
              msg: "Network Error",
            );
          } else if (state is HttpError) {
            return const HttpExc(
              msg: "Server Error contact system Admin",
            );
          } else {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.3),
              ),
              itemCount: state.subs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value: PodcastsCubit(repository: repository)),
                            BlocProvider.value(
                              value: UserCubit(repository: repository),
                            )
                          ],
                          child: Subs(
                            details: state.subs[index],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: 'http://167.99.86.191' +
                                  state.subs[index]['cover_art'],
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: btnColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          state.subs[index]['title'],
                          style: podstyles,
                          textAlign: TextAlign.center,
                          maxLines:1,
                          overflow:TextOverflow.ellipsis,
                        ),
                        Text(
                          state.subs[index]['author'],
                          style: TextStyle(color: Colors.grey[400]),
                          maxLines:1,
                          overflow:TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return const CirculaIndicator();
        }
      },
    );
  }
}
