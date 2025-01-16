import 'dart:convert';

PostCommentDataModel postCommentDataModelFromJson(String str) =>
    PostCommentDataModel.fromJson(json.decode(str));

String postCommentDataModelToJson(PostCommentDataModel data) =>
    json.encode(data.toJson());

class PostCommentDataModel {
  int code;
  String message;
  List<PostComment> data;

  PostCommentDataModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PostCommentDataModel.fromJson(Map<String, dynamic> json) =>
      PostCommentDataModel(
        code: json["code"] ?? -1, // Default to -1 if code is missing
        message: json["message"] ?? "Unknown error",
        data: (json["data"] == null ||
                (json["data"] is List && json["data"].isEmpty))
            ? [] // Return an empty list if data is null or an empty list
            : List<PostComment>.from(
                json["data"].map((x) => PostComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PostComment {
  final String? postId;
  final String? commenId;
  final String? commentByUserAvatar;
  final String? commentByUser;
  final String comment;

  PostComment({
    this.postId,
    this.commenId,
    this.commentByUserAvatar,
    this.commentByUser,
    required this.comment,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        postId: json["postId"],
        commenId: json["commenId"],
        commentByUserAvatar: json["commentByUserAvatar"],
        commentByUser: json["commentByUser"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "commenId": commenId,
        "commentByUserAvatar": commentByUserAvatar,
        "commentByUser": commentByUser,
        "comment": comment,
      };
}
