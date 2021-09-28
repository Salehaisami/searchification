import 'package:flutter/material.dart';
import 'package:searchification/models/search_result.dart';
import 'package:gallery_saver/gallery_saver.dart';

/// Creates a card with a gesture detector around the thumbnail image to
/// allow full image view to show on tap. The full image view is provided by
/// the [DialogBuilder] class defined below.
///
class DetailedImageView extends StatelessWidget {
  final SearchResultImage image;
  const DetailedImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalUrl = image.originalUrl ??
        image.thumbnailUrl ??
        'https://picsum.photos/250?image=9';
    final thumbnailUrl = image.thumbnailUrl ??
        image.originalUrl ??
        'https://picsum.photos/250?image=9';
    return Card(
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
        child: Image.network(thumbnailUrl),
        onTap: () async {
          await showDialog(
            context: context,
            builder: (alertContext) => ImageDialogBuilder(url: originalUrl),
          );
        },
      ),
    );
  }
}


/// Returns a simple dialog which shows the original image in a bigger format,
/// while the other thumbnails are blurred out.
///
class ImageDialogBuilder extends StatefulWidget {
  final url;

  const ImageDialogBuilder({Key? key, this.url}) : super(key: key);

  @override
  _ImageDialogBuilderState createState() => _ImageDialogBuilderState();
}

class _ImageDialogBuilderState extends State<ImageDialogBuilder> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return (isSaved) ? SimpleDialog(
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.url), fit: BoxFit.contain)),
        ),
        ElevatedButton(
          child: Text(
            'Your Image was successfully saved!!!',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.green)),
        ),
      ],
    ) : SimpleDialog(
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.url), fit: BoxFit.contain)),
        ),
        ElevatedButton(
          child: Text(
            'Click to save image',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () async => GallerySaver.saveImage(widget.url).then((success) {
            success = success ?? false;
            if (success != isSaved) setState(() {
              isSaved = success!;
            });
          }),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.black)),
        ),
      ],
    );
  }
}
