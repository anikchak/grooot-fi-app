class FeedDataModel {
  FeedDataModel({
    required this.code, // Mandatory field with a default fallback
    this.message,
    required this.data,
  });

  final int code; // Mandatory field
  final String? message;
  final List<Feed> data;

  factory FeedDataModel.fromJson(Map<String, dynamic> json) {
    return FeedDataModel(
      code: json["code"] ?? -1, // Default to -1 if code is missing
      message: json["message"] ?? "Unknown error",
      data: (json["data"] == null ||
              (json["data"] is List && json["data"].isEmpty))
          ? [] // Return an empty list if data is null or an empty list
          : List<Feed>.from(json["data"].map((x) => Feed.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Feed {
  Feed({
    this.postId,
    this.categoryAvatar,
    this.category,
    this.createdBy,
    this.postCreatedByUserId,
    this.isAnonymous,
    this.postTitle,
    this.postDescription,
    this.upvotesCount,
    this.commentCount,
    this.postCreatedTimestamp,
  });

  final String? postId;
  final String? categoryAvatar;
  final String? category;
  final String? createdBy;
  final String? postCreatedByUserId;
  final bool? isAnonymous;
  final String? postTitle;
  final String? postDescription;
  final int? upvotesCount;
  final int? commentCount;
  final int? postCreatedTimestamp;

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      postId: json["postId"],
      categoryAvatar: json["categoryAvatar"],
      category: json["category"],
      createdBy: json["createdBy"],
      postCreatedByUserId: json["postCreatedByUserId"],
      isAnonymous: json["isAnonymous"],
      postTitle: json["postTitle"],
      postDescription: json["postDescription"],
      upvotesCount: json["upvotesCount"],
      commentCount: json["commentCount"],
      postCreatedTimestamp: json["postCreatedTimestamp"],
    );
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "categoryAvatar": categoryAvatar,
        "category": category,
        "createdBy": createdBy,
        "postCreatedByUserId": postCreatedByUserId,
        "isAnonymous": isAnonymous,
        "postTitle": postTitle,
        "postDescription": postDescription,
        "upvotesCount": upvotesCount,
        "commentCount": commentCount,
        "postCreatedTimestamp": postCreatedTimestamp,
      };
}
