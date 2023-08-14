import 'package:rupify/Src/requirements.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


Widget paymentAndPeople(context,UserModelPrimary user){
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  void onRefresh() async{
    await Functions().fetchData(context,user);
    refreshController.refreshCompleted();
  }

  void onLoading() async{
    await Functions().fetchData(context,user);
    refreshController.loadComplete();
  }
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  List<MapEntry<String, String>> entries = dashBoardIcons.entries.toList();
  return Stack(
    children: [
      DraggableScrollableSheet(
        initialChildSize: 0.78,
        minChildSize: 0.78,
        maxChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          return Stack(
            children: [
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp:  true,
                  header: const WaterDropHeader(waterDropColor: Colors.white,complete: Text('Fetched Notes Successfully',style: TextStyle(color: Colors.white,fontSize: 20))),
                  onRefresh: onRefresh,
                  onLoading: onLoading,
                  controller: refreshController,
                  child: ListView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: height,
                        width: width,
                        child: Stack(
                          children: [
                            Positioned(
                              top:45,
                              left: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                                child: Container(
                                  height: height,
                                  width: width,
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const SizedBox(height: 65),
                                        paymentList(context, entries),
                                        people(context),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: paymentCard(context, user),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    ],
  );
}