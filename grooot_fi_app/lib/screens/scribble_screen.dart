import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooot_fi_app/components/comments_bottom_sheet.dart';
import 'package:grooot_fi_app/datamodels/feed_data_model.dart';
import '../services/feed_service.dart';

class ScribbleScreen extends StatefulWidget {
  final Function(bool) toggleBottomNavBarVisibility;
  const ScribbleScreen({super.key, required this.toggleBottomNavBarVisibility});

  @override
  State<ScribbleScreen> createState() => _ScribbleScreenState();
}

class _ScribbleScreenState extends State<ScribbleScreen> {
  final FeedService feedService = FeedService();
  List<Feed> feeds = [];
  Map<int, bool> expandedStates =
      {}; // Track expanded states for each container

  bool isLoading = true;
  int offset = 0;
  int limit = 20;
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _fetchFeeds(); // Fetch feeds when the screen initializes
  }

  Future<void> _fetchFeeds({bool isRefresh = false}) async {
    if (isRefresh) {
      offset = 0;
      hasMore = true;
    }
    if (!hasMore || isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final feedData = await feedService.fetchFeeds(offset: offset);
      setState(() {
        if (isRefresh) {
          feeds = feedData.data; // Replace data on refresh
        } else {
          feeds.addAll(feedData.data); // Append data for pagination
        }
        offset += feedData.data.length;
        if (feedData.data.length < limit) hasMore = false; // No more data
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching feeds: $error')),
      );
    } finally {
      setState(() {
        isLoadingMore = false;
        isLoading = false;
      });
    }
  }

  bool _shouldShowMore(String? text, BuildContext context) {
    if (text == null || text.isEmpty) return false;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(fontSize: 14),
        ),
      ),
      maxLines: 7,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth:
            MediaQuery.of(context).size.width - 32); // Subtract padding/margins

    return textPainter.didExceedMaxLines;
  }

  void _showCommentsModal(BuildContext context, String postId) {
    widget.toggleBottomNavBarVisibility(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: const Color(0xFF2C2C2C).withOpacity(0.9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CommentsBottomSheet(
          commentsFuture: feedService.fetchComments(postId),
          onCommentAdded: () {
            // Add logic to handle adding a new comment
            print('New comment added!');
          },
        );
      },
    ).whenComplete(() {
      widget.toggleBottomNavBarVisibility(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "What's the buzz",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 8.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.add_rounded,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.white,
            height: 1.0,
          ),
        ),
        toolbarHeight: 50,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFCDEB3F),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => _fetchFeeds(isRefresh: true),
              child: ListView.builder(
                itemCount: feeds.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < feeds.length) {
                    final feed = feeds[index];
                    bool isExpanded = expandedStates[index] ?? false;

                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: feed.categoryAvatar != null
                                    ? NetworkImage(feed.categoryAvatar!)
                                    : const AssetImage(
                                            'assets/images/avatar.png')
                                        as ImageProvider,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feed.category ?? 'Category',
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFCDEB3F),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'posted by ${feed.createdBy ?? 'Unknown'}',
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feed.postTitle ?? 'Post title missing',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (_shouldShowMore(
                                  feed.postDescription, context))
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      expandedStates[index] = !isExpanded;
                                    });
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: isExpanded
                                              ? feed.postDescription ??
                                                  'Post description missing'
                                              : '${feed.postDescription?.split(' ').take(50).join(' ')}',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: isExpanded
                                              ? ' ...show less'
                                              : ' ...show more',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFCDEB3F),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  feed.postDescription ?? '',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (feed.isUpvoted) {
                                      // Decrement upvotes and unmark as upvoted
                                      feed.upvotesCount =
                                          (feed.upvotesCount ?? 0) - 1;
                                      feed.isUpvoted = false;
                                    } else {
                                      // Increment upvotes and mark as upvoted
                                      feed.upvotesCount =
                                          (feed.upvotesCount ?? 0) + 1;
                                      feed.isUpvoted = true;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      feed.isUpvoted
                                          ? 'images/upvote_filled.svg'
                                          : 'images/upvote_outlined.svg',
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      (feed.upvotesCount ?? 0) == 0
                                          ? 'Upvote'
                                          : '${feed.upvotesCount}',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 25),
                              GestureDetector(
                                onTap: () {
                                  _showCommentsModal(
                                      context, feed.postId ?? '');
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.sms_outlined,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      (feed.commentCount ?? 0) == 0
                                          ? 'Comment'
                                          : '${feed.commentCount}',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.white,
                            thickness: 1.0,
                            height: 1.0,
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Show loading indicator for "Load More"
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
    );
  }
}
