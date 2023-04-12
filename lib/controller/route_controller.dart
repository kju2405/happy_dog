import 'package:get/get.dart';
import 'package:happy_dog/model/route_thumb.dart';

class RouteController extends GetxController {
  final routeThumb = RouteThumb().obs;

  void updateInfo() {
    routeThumb.update((val) {
      val?.num++;
    });
  }
}
