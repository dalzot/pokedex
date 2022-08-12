part of 'details_bloc.dart';

abstract class DetailsEvent {
  const DetailsEvent();
}

class GetDetailsEvent extends DetailsEvent{
  final String url;
  GetDetailsEvent(this.url);
}