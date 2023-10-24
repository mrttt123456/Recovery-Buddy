import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

/// An extension method on Stream's [User] class - to easily access user data
/// properties used in this sample application.
extension UserData on User {
  String get handle => data?['handle'] as String? ?? '';
  String get firstName => data?['first_name'] as String? ?? '';
  String get lastName => data?['last_name'] as String? ?? '';
  String get fullName => data?['full_name'] as String? ?? '';
  String get profileImage => data?['profile_image'] as String? ?? '';
}

/// Page that displays the "timeline" Stream feed group.
///
/// This is a combination of your activities, and the users you follow.
///
/// Displays your reactions, and reaction counts.
class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final EnrichmentFlags _flags = EnrichmentFlags()
    ..withReactionCounts()
    ..withOwnReactions();

  bool _isPaginating = false;

  static const _feedGroup = 'timeline';

  Future<void> _loadMore() async {
    // Ensure we're not already loading more activities.
    if (!_isPaginating) {
      _isPaginating = true;
      context.feedBloc
          .loadMoreEnrichedActivities(feedGroup: _feedGroup, flags: _flags)
          .whenComplete(() {
        _isPaginating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = context.feedClient;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
        automaticallyImplyLeading: false,
      ),
      body: FlatFeedCore(
        feedGroup: _feedGroup,
        userId: client.currentUser!.id,
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        emptyBuilder: (context) => const Center(child: Text('No activities')),
        errorBuilder: (context, error) => Center(
          child: Text(error.toString()),
        ),
        limit: 10,
        flags: _flags,
        feedBuilder: (
          BuildContext context,
          activities,
        ) {
          return RefreshIndicator(
            onRefresh: () {
              return context.feedBloc.refreshPaginatedEnrichedActivities(
                feedGroup: _feedGroup,
                flags: _flags,
              );
            },
            child: ListView.separated(
              itemCount: activities.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                bool shouldLoadMore = activities.length - 3 == index;
                if (shouldLoadMore) {
                  _loadMore();
                }
                return ListActivityItem(
                  activity: activities[index],
                  feedGroup: _feedGroup,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (context) => const ComposeActivityPage()),
          );
        },
        tooltip: 'Add Activity',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListActivityItem extends StatelessWidget {
  const ListActivityItem({
    Key? key,
    required this.activity,
    required this.feedGroup,
  }) : super(key: key);

  final EnrichedActivity activity;
  final String feedGroup;

  @override
  Widget build(BuildContext context) {
    final actor = activity.actor!;
    final attachments = (activity.extraData)?.toAttachments();
    final reactionCounts = activity.reactionCounts;
    final ownReactions = activity.ownReactions;
    final isLikedByUser = (ownReactions?['like']?.length ?? 0) > 0;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(actor.profileImage),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Text(actor.fullName),
            const SizedBox(width: 8),
            Text(
              actor.handle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('${activity.object}'),
          ),
          if (attachments != null && attachments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.network(attachments[0].url),
            ),
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    iconSize: 16,
                    onPressed: () {
                      if (isLikedByUser) {
                        context.feedBloc.onRemoveReaction(
                          kind: 'like',
                          activity: activity,
                          reaction: ownReactions!['like']![0],
                          feedGroup: feedGroup,
                        );
                      } else {
                        context.feedBloc.onAddReaction(
                            kind: 'like',
                            activity: activity,
                            feedGroup: feedGroup);
                      }
                    },
                    icon: isLikedByUser
                        ? const Icon(Icons.favorite_rounded)
                        : const Icon(Icons.favorite_outline),
                  ),
                  if (reactionCounts?['like'] != null)
                    Text(
                      '${reactionCounts?['like']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  IconButton(
                    iconSize: 16,
                    onPressed: () => _navigateToCommentPage(context),
                    icon: const Icon(Icons.mode_comment_outlined),
                  ),
                  if (reactionCounts?['comment'] != null)
                    Text(
                      '${reactionCounts?['comment']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  IconButton(
                    iconSize: 16,
                    onPressed: () {
                      context.feedBloc.onRemoveActivity(
                        activityId: activity.id ?? "",
                        feedGroup: feedGroup,
                      );
                    },
                    icon: const Icon(Icons.delete_outline_outlined),
                  )
                ],
              )
            ],
          )
        ],
      ),
      onTap: () {
        _navigateToCommentPage(context);
      },
    );
  }

  void _navigateToCommentPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => CommentsPage(
          activity: activity,
        ),
      ),
    );
  }
}

/// A page to compose a new [Activity]/post.
///
/// - feed: "user"
/// - verb: "post"
/// - object: "text data"
/// - data: media
///
/// [More information](https://getstream.io/activity-feeds/docs/flutter-dart/adding_activities/?language=dart) on activities.
class ComposeActivityPage extends StatefulWidget {
  final String? preFilledText;
  final String? preFilledImage;

  const ComposeActivityPage({
    Key? key,
    this.preFilledText,
    this.preFilledImage,
  }) : super(key: key);

  @override
  State<ComposeActivityPage> createState() => _ComposeActivityPageState();
}

class _ComposeActivityPageState extends State<ComposeActivityPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.preFilledText != null) {
      _textEditingController.text = widget.preFilledText!;
    }
    if (widget.preFilledImage != null) {
      // Assuming the context.feedUploadController.uploadImage takes a URI
      context.feedUploadController
          .uploadImage(AttachmentFile(path: widget.preFilledImage!));
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  /// "Post" a new activity to the "user" feed group.
  Future<void> _post() async {
    final uploadController = context.feedUploadController;
    final media = uploadController.getMediaUris()?.toExtraData();
    if (_textEditingController.text.isNotEmpty) {
      await context.feedBloc.onAddActivity(
        feedGroup: 'user',
        verb: 'post',
        object: _textEditingController.text,
        data: media,
      );
      uploadController.clear();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot post with no message')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ActionChip(
              label: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              backgroundColor: Colors.white,
              onPressed: _post,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration:
                      const InputDecoration(hintText: "What's on your mind"),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 600,
                        maxWidth: 300,
                        imageQuality: 50,
                      );

                      if (image != null) {
                        await context.feedUploadController
                            .uploadImage(AttachmentFile(path: image.path));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cancelled')));
                      }
                    },
                    icon: const Icon(Icons.file_copy),
                  ),
                  Text(
                    'Add a Photo',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              UploadListCore(
                uploadController: context.feedUploadController,
                loadingBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                uploadsErrorBuilder: (error) =>
                    Center(child: Text(error.toString())),
                uploadsBuilder: (context, uploads) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: uploads.length,
                      itemBuilder: (context, index) => FileUploadStateWidget(
                          fileState: uploads[index],
                          onRemoveUpload: (attachment) {
                            return context.feedUploadController
                                .removeUpload(attachment);
                          },
                          onCancelUpload: (attachment) {
                            return context.feedUploadController
                                .cancelUpload(attachment);
                          },
                          onRetryUpload: (attachment) async {
                            return context.feedUploadController
                                .uploadImage(attachment);
                          }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A page that displays all [Reaction]s/comments for a specific
/// [Activity]/Post.
///
/// Enabling the current [User] to add comments and like other reactions.
class CommentsPage extends StatefulWidget {
  const CommentsPage({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final EnrichedActivity activity;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  bool _isPaginating = false;

  final EnrichmentFlags _flags = EnrichmentFlags()..withOwnChildren();

  Future<void> _loadMore() async {
    // Ensure we're not already loading more reactions.
    if (!_isPaginating) {
      _isPaginating = true;
      context.feedBloc
          .loadMoreReactions(widget.activity.id!, flags: _flags)
          .whenComplete(() {
        _isPaginating = false;
      });
    }
  }

  Future<void> _addOrRemoveLike(Reaction reaction) async {
    final isLikedByUser = (reaction.ownChildren?['like']?.length ?? 0) > 0;
    if (isLikedByUser) {
      FeedProvider.of(context).bloc.onRemoveChildReaction(
            kind: 'like',
            childReaction: reaction.ownChildren!['like']![0],
            lookupValue: widget.activity.id!,
            parentReaction: reaction,
          );
    } else {
      FeedProvider.of(context).bloc.onAddChildReaction(
            kind: 'like',
            reaction: reaction,
            lookupValue: widget.activity.id!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: ReactionListCore(
              lookupValue: widget.activity.id!,
              kind: 'comment',
              loadingBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              emptyBuilder: (context) =>
                  const Center(child: Text('No comment reactions')),
              errorBuilder: (context, error) => Center(
                child: Text(error.toString()),
              ),
              flags: _flags,
              reactionsBuilder: (context, reactions) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: RefreshIndicator(
                    onRefresh: () {
                      return context.feedBloc.refreshPaginatedReactions(
                        widget.activity.id!,
                        flags: _flags,
                      );
                    },
                    child: ListView.separated(
                      itemCount: reactions.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        bool shouldLoadMore = reactions.length - 3 == index;
                        if (shouldLoadMore) {
                          _loadMore();
                        }

                        final reaction = reactions[index];
                        final isLikedByUser =
                            (reaction.ownChildren?['like']?.length ?? 0) > 0;
                        final user = reaction.user;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user!.profileImage),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${reaction.data?['text']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          trailing: IconButton(
                            iconSize: 14,
                            onPressed: () {
                              _addOrRemoveLike(reaction);
                            },
                            icon: isLikedByUser
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_border),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          AddCommentBox(activity: widget.activity)
        ],
      ),
    );
  }
}

/// UI widget that displays a [TextField] to add a [Reaction]/Comment to a
/// particular [activity].
class AddCommentBox extends StatefulWidget {
  const AddCommentBox({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final EnrichedActivity activity;

  @override
  State<AddCommentBox> createState() => _AddCommentBoxState();
}

class _AddCommentBoxState extends State<AddCommentBox> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> _addComment() async {
    final value = textController.text;
    textController.clear();

    if (value.isNotEmpty) {
      context.feedBloc.onAddReaction(
        kind: 'comment',
        activity: widget.activity,
        feedGroup: 'timeline',
        data: {'text': value},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
      child: TextField(
        controller: textController,
        onSubmitted: ((value) {
          _addComment();
        }),
        decoration: InputDecoration(
          hintText: 'Add a comment',
          suffix: IconButton(
            onPressed: _addComment,
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
