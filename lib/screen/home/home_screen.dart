import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logique_techtest/components/card_user.dart';
import 'package:logique_techtest/components/circular_progress.dart';
import 'package:logique_techtest/components/refresh_indicator.dart';
import 'package:logique_techtest/components/shimmer_user.dart';
import 'package:logique_techtest/models/user.dart';
import 'package:logique_techtest/repositories/api_request.dart';
import 'package:logique_techtest/routes/navigator.dart';
import 'package:logique_techtest/screen/home/home_provider.dart';
import 'package:logique_techtest/utils/size_config.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.userPagingController.addPageRequestListener((pageKey) async {
      if (mounted) {
        await provider.getDataUser(
          page: pageKey,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return Container(
      color: Colors.blueGrey[300],
      child: SafeArea(
        child: Scaffold(
          body: CustomRefresh.customRefreshIndicator(
            onRefresh: () async {
              provider.userPagingController.refresh();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Users",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PagedGridView(
                      shrinkWrap: true,
                      pagingController: provider.userPagingController,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<User>(
                        itemBuilder: (context, user, index) {
                          return CardUser(
                            id: user.id,
                            firstName: user.firstName,
                            lastName: user.lastName,
                            title: user.title,
                            picture: user.picture,
                            onTap: () => goToDetailUserScreen(
                              context,
                              id: user.id ?? '',
                              name: user.firstName ?? '',
                            ),
                          );
                        },
                        newPageProgressIndicatorBuilder: (context) => Row(
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgress.inicator(),
                            ),
                            const Spacer(),
                          ],
                        ),
                        firstPageProgressIndicatorBuilder: (context) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: 4,
                              itemBuilder: (context, index) => ShimmerUser(),
                            ),
                          ],
                        ),
                        noItemsFoundIndicatorBuilder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "No User Found.",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                ),
                label: "User",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.new_label,
                ),
                label: "New",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: "Like",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
