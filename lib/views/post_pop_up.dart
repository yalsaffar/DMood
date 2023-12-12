import 'package:flutter/material.dart';

class PostPopUp extends StatelessWidget {
  final String imagePath;
  final String caption;
  final int likeCount;
  final bool isUpvoted;
  final String userName;
  final String userLastName;
  final String postDate;
  final String postId;
  final Function onDelete;

  PostPopUp({
    required this.imagePath,
    required this.caption,
    required this.likeCount,
    required this.userName,
    required this.userLastName,
    required this.postDate,
    this.isUpvoted = false,
    required this.postId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft, // Align the close icon to the left
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(postId),
                ),
              ),
            ],
          ),
          imagePath.startsWith('http')
              ? Image.network(imagePath, fit: BoxFit.cover)
              : Image.asset(imagePath, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$userName $userLastName - $postDate',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(isUpvoted ? Icons.thumb_up : Icons.thumb_down,
                            color: isUpvoted ? Colors.green : Colors.red),
                        SizedBox(width: 4),
                        Text('$likeCount likes', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(caption,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Comment 1: Great Post!',
                    style: TextStyle(color: Colors.grey)),
                Text('Comment 2: Love this!',
                    style: TextStyle(color: Colors.grey)),
                Text('Comment 3: Awesome!',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
