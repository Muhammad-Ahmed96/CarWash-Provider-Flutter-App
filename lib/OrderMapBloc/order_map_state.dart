import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderMapState extends Equatable {
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  OrderMapState(this.polylines, this.markers);

  @override
  List<Object> get props => [polylines, markers];

  @override
  bool get stringify => true;
}
