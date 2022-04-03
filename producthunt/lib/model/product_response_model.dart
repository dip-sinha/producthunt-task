import 'dart:convert';

class ProductListResModel {
  ProductList?productList;
  ProductListResModel({this.productList});
  factory ProductListResModel.fromJson(Map<String, dynamic> json) {
    return ProductListResModel(
        productList:  ProductList.fromJson(json),
    );
  }
}

class ProductList {
  List<Post> posts = [];
  ProductList({this.posts = const []});
  ProductList.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts.add(Post.fromJson(v));
      });
    }
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   if (posts != null) {
  //     data['posts'] = posts.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

  Map<String, dynamic> toMap() { // for saving into local
    return {
      'posts': posts.map((x) => x.toJson()).toList(),
    };
  }
  String toJson() => json.encode(toMap());

  factory ProductList.fromString(String source) =>
      ProductList.fromJson(json.decode(source));
}

class Post {
  int? commentsCount;
  int? id;
  String? name;
  String? productState;
  String? tagline;
  String? slug;
  int? votesCount;
  String? day;
  String? createdAt;
  CurrentUser? currentUser;
  String? discussionUrl;
  bool? featured;
  bool? iosFeaturedAt;
  bool? makerInside;
  List<Makers>? makers;
  String? redirectUrl;
  Thumbnail? thumbnail;
  List<Topics>? topics;
  User? user;
  int? reviewsCount;
  List<Badges>? badges;
  List<Comments>? comments;
  List<Votes>? votes;
  List<RelatedPosts>? relatedPosts;
  List<InstallLinks>? installLinks;
  List<Media>? media;
  String? description;

  Post(
      {this.commentsCount,
      this.id,
      this.name,
      this.productState,
      this.tagline,
      this.slug,
      this.votesCount,
      this.day,
      this.createdAt,
      this.currentUser,
      this.discussionUrl,
      this.featured,
      this.iosFeaturedAt,
      this.makerInside,
      this.makers,
      this.redirectUrl,
      this.thumbnail,
      this.topics,
      this.user,
      this.reviewsCount,
      this.badges,
      this.comments,
      this.votes,
      this.relatedPosts,
      this.installLinks,
      this.media,
      this.description});

  Post.fromJson(Map<String, dynamic> json) {
    commentsCount = json['comments_count'];
    id = json['id'];
    name = json['name'];
    productState = json['product_state'];
    tagline = json['tagline'];
    slug = json['slug'];
    votesCount = json['votes_count'];
    day = json['day'];
    createdAt = json['created_at'];
    currentUser = json['current_user'] != null
        ?   CurrentUser.fromJson(json['current_user'])
        : null;
    discussionUrl = json['discussion_url'];
    featured = json['featured'];
    iosFeaturedAt = json['ios_featured_at'];
    makerInside = json['maker_inside'];
    if (json['makers'] != null) {
      makers = <Makers>[];
      json['makers'].forEach((v) {
        makers!.add(  Makers.fromJson(v));
      });
    }
    redirectUrl = json['redirect_url'];
    thumbnail = json['thumbnail'] != null
        ?   Thumbnail.fromJson(json['thumbnail'])
        : null;
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(  Topics.fromJson(v));
      });
    }
    user = json['user'] != null ?   User.fromJson(json['user']) : null;
    reviewsCount = json['reviews_count'];
    if (json['badges'] != null) {
      badges = <Badges>[];
      json['badges'].forEach((v) {
        badges!.add(  Badges.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(  Comments.fromJson(v));
      });
    }
    if (json['votes'] != null) {
      votes = <Votes>[];
      json['votes'].forEach((v) {
        votes!.add(  Votes.fromJson(v));
      });
    }
    if (json['related_posts'] != null) {
      relatedPosts = <RelatedPosts>[];
      json['related_posts'].forEach((v) {
        relatedPosts!.add(  RelatedPosts.fromJson(v));
      });
    }
    if (json['install_links'] != null) {
      installLinks = <InstallLinks>[];
      json['install_links'].forEach((v) {
        installLinks!.add(  InstallLinks.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['comments_count'] = commentsCount;
    data['id'] = id;
    data['name'] = name;
    data['product_state'] = productState;
    data['tagline'] = tagline;
    data['slug'] = slug;
    data['votes_count'] = votesCount;
    data['day'] = this.day;
    data['created_at'] = this.createdAt;
    if (this.currentUser != null) {
      data['current_user'] = this.currentUser!.toJson();
    }
    data['discussion_url'] = this.discussionUrl;

    data['featured'] = this.featured;
    data['ios_featured_at'] = this.iosFeaturedAt;
    data['maker_inside'] = this.makerInside;
    if (this.makers != null) {
      data['makers'] = this.makers!.map((v) => v.toJson()).toList();
    }
    data['redirect_url'] = this.redirectUrl;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
  bool filter(String query) =>
      ((name ?? "").toLowerCase().contains(query.toLowerCase())) ||
      ((tagline ?? "").toLowerCase().contains(query.toLowerCase()));

}

class CurrentUser {
  bool? votedForPost;
  bool? commentedOnPost;

  CurrentUser({this.votedForPost, this.commentedOnPost});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    votedForPost = json['voted_for_post'];
    commentedOnPost = json['commented_on_post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voted_for_post'] = votedForPost;
    data['commented_on_post'] = commentedOnPost;
    return data;
  }
}

class Makers {
  int? id;
  String? createdAt;
  String? name;
  String? username;
  String? headline;
  String? twitterUsername;
  String? websiteUrl;
  String? profileUrl;

  Makers({
    this.id,
    this.createdAt,
    this.name,
    this.username,
    this.headline,
    this.twitterUsername,
    this.websiteUrl,
    this.profileUrl,
  });

  Makers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    username = json['username'];
    headline = json['headline'];
    twitterUsername = json['twitter_username'];
    websiteUrl = json['website_url'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data["created_at"] =createdAt;
    data["name"] = name;
    data["username"] = username;
    data["headline"] =headline;
    data["twitter_username"] =twitterUsername;
    data["twitter_username"] =websiteUrl;
    data["profile_url"] =profileUrl;
    return data;
  }
}

class Thumbnail {
  String? id;
  String? mediaType;
  String? imageUrl;
  Post? metadata;

  Thumbnail({this.id, this.mediaType, this.imageUrl, this.metadata});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    imageUrl = json['image_url'];
    metadata =
        json['metadata'] != null ?   Post.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['media_type'] = mediaType;
    data['image_url'] = imageUrl;
    data['image_url'] = imageUrl;
    if (metadata != null) {
      data['metadata'] = metadata?.toJson();
    }
    return data;
  }
}

class Topics {
  int? id;
  String? name;
  String? slug;

  Topics({this.id, this.name, this.slug});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
  return data;
  }
}

class Badges {
  int? id;
  String? type;
  Data? data;

  Badges({this.id, this.type, this.data});

  Badges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? date;
  String? period;
  int? position;

  Data({this.date, this.period, this.position});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    period = json['period'];
    position = json['position'];
  }
}

class User {
  int? id;
  String? createdAt;
  String? name;
  String? username;
  String? headline;
  String? twitterUsername;
  String? websiteUrl;
  String? profileUrl;
  Map<String, String>? imageUrl;
  User(
      {this.id,
      this.createdAt,
      this.name,
      this.username,
      this.headline,
      this.twitterUsername,
      this.websiteUrl,
      this.profileUrl,
      this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    username = json['username'];
    headline = json['headline'];
    twitterUsername = json['twitter_username'];
    websiteUrl = json['website_url'];
    profileUrl = json['profile_url'];
    imageUrl = json["image_url"] == null? null:Map.from(json["image_url"])
        .map((k, v) => MapEntry<String, String>(k, v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']= id;
    data['created_at']= createdAt;
    data['name']= name;
    data['headline']= headline;
    data['twitter_username']= twitterUsername;
    data['website_url'] = websiteUrl;
    data['profile_url'] = profileUrl;
    return data;
  }
}

class Votes {
  int? id;
  String? createdAt;
  int? userId;
  int? postId;
  User? user;

  Votes({this.id, this.createdAt, this.userId, this.postId, this.user});

  Votes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    postId = json['post_id'];
    user = json['user'] != null ?   User.fromJson(json['user']) : null;
  }
}

class RelatedPosts {
  int? commentsCount;
  int? id;
  String? name;
  String? productState;
  String? tagline;
  String? slug;
  int? votesCount;
  String? day;
  String? createdAt;
  CurrentUser? currentUser;
  String? discussionUrl;
  bool? featured;
  bool? iosFeaturedAt;
  bool? makerInside;
  List<Makers>? makers;
  String? redirectUrl;
  Thumbnail? thumbnail;
  List<Topics>? topics;
  User? user;

  RelatedPosts(
      {this.commentsCount,
      this.id,
      this.name,
      this.productState,
      this.tagline,
      this.slug,
      this.votesCount,
      this.day,
      this.createdAt,
      this.currentUser,
      this.discussionUrl,
      this.featured,
      this.iosFeaturedAt,
      this.makerInside,
      this.makers,
      this.redirectUrl,
      this.thumbnail,
      this.topics,
      this.user});

  RelatedPosts.fromJson(Map<String, dynamic> json) {
    commentsCount = json['comments_count'];
    id = json['id'];
    name = json['name'];
    productState = json['product_state'];
    tagline = json['tagline'];
    slug = json['slug'];
    votesCount = json['votes_count'];
    day = json['day'];
    createdAt = json['created_at'];
    currentUser = json['current_user'] != null
        ?   CurrentUser.fromJson(json['current_user'])
        : null;
    discussionUrl = json['discussion_url'];
    featured = json['featured'];
    iosFeaturedAt = json['ios_featured_at'];
    makerInside = json['maker_inside'];
    if (json['makers'] != null) {
      makers = <Makers>[];
      json['makers'].forEach((v) {
        makers!.add(  Makers.fromJson(v));
      });
    }
    redirectUrl = json['redirect_url'];
    thumbnail = json['thumbnail'] != null
        ?   Thumbnail.fromJson(json['thumbnail'])
        : null;
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(  Topics.fromJson(v));
      });
    }
    user = json['user'] != null ?   User.fromJson(json['user']) : null;
  }
}

class InstallLinks {
  int? id;
  int? postId;
  String? createdAt;
  bool? primaryLink;
  String? websiteName;
  String? redirectUrl;
  String? platform;

  InstallLinks(
      {this.id,
      this.postId,
      this.createdAt,
      this.primaryLink,
      this.websiteName,
      this.redirectUrl,
      this.platform});

  InstallLinks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    primaryLink = json['primary_link'];
    websiteName = json['website_name'];
    redirectUrl = json['redirect_url'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['created_at'] = this.createdAt;
    data['primary_link'] = this.primaryLink;
    data['website_name'] = this.websiteName;
    data['redirect_url'] = this.redirectUrl;
    data['platform'] = this.platform;
    return data;
  }
}

class Media {
  int? id;
  int? priority;
  int? originalWidth;
  int? originalHeight;
  MetaData? metadata;
  String? imageUrl;
  String? mediaType;
  String? platform;
  String? videoId;

  Media(
      {this.id,
      this.priority,
      this.originalWidth,
      this.originalHeight,
      this.metadata,
      this.imageUrl,
      this.platform,
      this.videoId,
      this.mediaType});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priority = json['priority'];
    originalWidth = json['original_width'];
    originalHeight = json['original_height'];
    metadata = json['metadata'] != null
        ?   MetaData.fromJson(json['metadata'])
        : null;
    imageUrl = json['image_url'];
    mediaType = json['media_type'];
    platform = json['platform'];
    videoId = json['video_id'];
  }
}

class MetaData {
  String? url;
  String? videoId;
  String? platform;

  MetaData({this.url, this.videoId, this.platform});

  MetaData.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    videoId = json['video_id'];
    platform = json['platform'];
  }
}

class ChildComments {
  int? id;
  String? body;
  String? createdAt;
  int? parentCommentId;
  int? userId;
  int? subjectId;
  int? childCommentsCount;
  String? url;
  int? postId;
  String? subjectType;
  bool? sticky;
  int? votes;
  Post? post;
  User? user;
  List<ChildComments>? childComments;
  bool? maker;
  bool? hunter;
  bool? liveGuest;

  ChildComments(
      {this.id,
      this.body,
      this.createdAt,
      this.parentCommentId,
      this.userId,
      this.subjectId,
      this.childCommentsCount,
      this.url,
      this.postId,
      this.subjectType,
      this.sticky,
      this.votes,
      this.post,
      this.user,
      this.childComments,
      this.maker,
      this.hunter,
      this.liveGuest});

  ChildComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    createdAt = json['created_at'];
    parentCommentId = json['parent_comment_id'];
    userId = json['user_id'];
    subjectId = json['subject_id'];
    childCommentsCount = json['child_comments_count'];
    url = json['url'];
    postId = json['post_id'];
    subjectType = json['subject_type'];
    sticky = json['sticky'];
    votes = json['votes'];
    post = json['post'] != null ?   Post.fromJson(json['post']) : null;
    user = json['user'] != null ?   User.fromJson(json['user']) : null;
    if (json['child_comments'] != null) {
      childComments = <ChildComments>[];
      json['child_comments'].forEach((v) {
        childComments!.add(  ChildComments.fromJson(v));
      });
    }
    maker = json['maker'];
    hunter = json['hunter'];
    liveGuest = json['live_guest'];
  }
}

class Comments {
  int? id;
  String? body;
  String? createdAt;
  int? parentCommentId;
  int? userId;
  int? subjectId;
  int? childCommentsCount;
  List<ChildComments> childComments = [];
  String? url;
  int? postId;
  String? subjectType;
  bool? sticky;
  int? votes;
  Post? post;
  User? user;
  bool? maker;
  bool? hunter;
  bool? liveGuest;

  Comments(
      {this.id,
      this.body,
      this.createdAt,
      this.parentCommentId,
      this.userId,
      this.subjectId,
      this.childCommentsCount,
      this.url,
      this.postId,
      this.subjectType,
      this.sticky,
      this.votes,
      this.post,
      this.user,
      this.maker,
      this.hunter,
      this.childComments = const [],
      this.liveGuest});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    createdAt = json['created_at'];
    parentCommentId = json['parent_comment_id'];
    userId = json['user_id'];
    subjectId = json['subject_id'];
    childCommentsCount = json['child_comments_count'];
    url = json['url'];
    postId = json['post_id'];
    subjectType = json['subject_type'];
    sticky = json['sticky'];
    votes = json['votes'];
    post = json['post'] != null ?   Post.fromJson(json['post']) : null;
    user = json['user'] != null ?   User.fromJson(json['user']) : null;
    maker = json['maker'];
    hunter = json['hunter'];
    liveGuest = json['live_guest'];
    if (json['child_comments'] != null) {
      childComments = <ChildComments>[];
      json['child_comments'].forEach((v) {
        childComments.add(ChildComments.fromJson(v));
      });
    }
  }
}
