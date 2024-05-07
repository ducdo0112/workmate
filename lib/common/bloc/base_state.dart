import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  /// Status of the current state.
  final BlocStatus status;

  /// Error of a call api.
  final NetworkException? exception;

  const BaseState({this.status = BlocStatus.initial, this.exception});

  @override
  List<Object?> get props => [status, exception];
}
