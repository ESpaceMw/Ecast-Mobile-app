part of 'network_cubit.dart';

@immutable
abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NewtworkConnected extends NetworkState {}

class NetworkDisconnected extends NetworkState {}
