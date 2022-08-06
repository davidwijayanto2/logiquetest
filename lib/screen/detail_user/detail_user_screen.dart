import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logique_techtest/components/shimmer.dart';
import 'package:logique_techtest/models/detail_user.dart';
import 'package:logique_techtest/screen/detail_user/detail_user_provider.dart';
import 'package:logique_techtest/utils/date_formatter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class DetailUserScreen extends StatefulWidget {
  final String id;
  final String name;
  const DetailUserScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  @override
  void initState() {
    final provider = context.read<DetailUserProvider>();
    provider.checkUser(widget.id);
    provider.getDetailUser(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Selector<DetailUserProvider, Map<String, dynamic>>(
              selector: (_, p) => {
                'detailUser': p.detailUser,
                'isFetching': p.isFetching,
              },
              builder: (_, data, __) {
                DetailUser? detailUser = data['detailUser'];
                bool isFetching = data['isFetching'];
                return isFetching
                    ? _shimmerPlaceholer()
                    : Column(
                        children: [
                          _header(),
                          const SizedBox(
                            height: 10,
                          ),
                          _profile(
                            detailUser,
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  _shimmerPlaceholer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Center(
          child: Shimmer(
            width: 125,
            skeletonStyle: SkeletonStyle.circle,
            radius: 100,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Shimmer(
            width: 70,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Shimmer(width: 90),
        SizedBox(
          height: 15,
        ),
        Shimmer(width: 150),
        SizedBox(
          height: 15,
        ),
        Shimmer(width: 100),
        SizedBox(
          height: 15,
        ),
        Shimmer(width: 200),
        SizedBox(
          height: 15,
        ),
        Shimmer(width: 150),
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: CupertinoTextField(
              prefix: const Padding(
                padding: EdgeInsets.only(
                  left: 5,
                ),
                child: Icon(Icons.search),
              ),
              placeholder: "Search in ${widget.name} posts",
            ),
          ),
        ],
      ),
    );
  }

  Widget _profile(DetailUser? detailUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<DetailUserProvider, bool>(
              selector: (_, p) => p.isFriend ?? false,
              builder: (_, isFriend, __) {
                return InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<DetailUserProvider>(context, listen: false);
                    if (!isFriend) {
                      provider.addFriend(widget.id);
                    } else {
                      provider.removeFriend(widget.id);
                    }
                  },
                  child: Icon(
                    isFriend ? Icons.check_circle : Icons.person_add,
                    size: 50,
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ExtendedImage.network(
              detailUser?.picture ?? '',
              borderRadius: BorderRadius.circular(100),
              width: 125,
              cache: true,
              fit: BoxFit.cover,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "${detailUser?.title} ${detailUser?.firstName} ${detailUser?.lastName}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Gender: ${detailUser?.gender}",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Date of Birth: ${DateFormatter.toShortDateText(context, detailUser?.registerDate != null ? DateTime.parse(detailUser?.dateOfBirth ?? '') : DateTime.now())}",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Join From: ${DateFormatter.toShortDateText(context, detailUser?.registerDate != null ? DateTime.parse(detailUser?.registerDate ?? '') : DateTime.now())}",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Email: ${detailUser?.email}",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Address: ${detailUser?.location?['street']}, ${detailUser?.location?['city']}, ${detailUser?.location?['state']}, ${detailUser?.location?['country']}",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
