// import 'package:flutter/material.dart';
// import 'package:movie_app/components/screen_title.dart';
// import 'package:movie_app/constants.dart';
// import 'package:movie_app/models/movie.dart';
// import 'package:provider/provider.dart';
// import 'package:movie_app/models/movies.dart';

// class AddContentScreen extends StatefulWidget {
//   AddContentScreen({Key? key, required this.isNew, this.id}) : super(key: key);
//   final bool isNew;
//   final String? id;

//   @override
//   State<AddContentScreen> createState() => _AddContentScreenState();
// }

// class _AddContentScreenState extends State<AddContentScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleFocusNode = FocusNode();
//   final _titleController = TextEditingController();
//   final _yearFocusNode = FocusNode();
//   final _yearController = TextEditingController();
//   final _ratingsQuantityFocusNode = FocusNode();
//   final _ratingsQuantityController = TextEditingController();
//   final _imdbRatingFocusNode = FocusNode();
//   final _imdbRatingController = TextEditingController();
//   final _metascoreFocusNode = FocusNode();
//   final _metascoreController = TextEditingController();
//   final _criticsReviewFocusNode = FocusNode();
//   final _criticsReviewController = TextEditingController();
//   final _ageRatingFocusNode = FocusNode();
//   final _ageRatingController = TextEditingController();
//   final _lengthFocusNode = FocusNode();
//   final _lengthController = TextEditingController();
//   final _plotFocusNode = FocusNode();
//   final _plotController = TextEditingController();
//   final _posterUrlController = TextEditingController();
//   final _posterUrlFocusNode = FocusNode();
//   final _backdropUrlController = TextEditingController();
//   final _backdropUrlFocusNode = FocusNode();
//   final _genresController = TextEditingController();
//   final _genresFocusNode = FocusNode();
//   final _actorUrlController = TextEditingController();
//   final _actorUrlFocusNode = FocusNode();
//   final _characterFocusNode = FocusNode();
//   final _actorNameController = TextEditingController();
//   final _characterController = TextEditingController();

//   List<String> _genres = [];
//   List<Member> _cast = [];
//   String contentType = '';
//   String platform = '';
//   Member _member = Member(originalName: '', movieName: '', image: '');
//   var _editedMovie = Movie(
//     poster: '',
//     backdrop: '',
//     title: '',
//     year: '',
//     numOfRatings: '',
//     metascoreRating: '',
//     criticsReview: '',
//     userRating: 0,
//     rating: '',
//     genre: [],
//     ageRating: '',
//     movieLength: '',
//     plot: '',
//     cast: [],
//     isFavorite: false,
//     contentType: '',
//   );

//   @override
//   void initState() {
//     if (widget.id != null) {
//       _editedMovie =
//           Provider.of<Movies>(context, listen: false).findById(widget.id!);

//       _titleController.text = _editedMovie.title;
//       _yearController.text = _editedMovie.year;
//       _ratingsQuantityController.text = _editedMovie.numOfRatings;
//       _imdbRatingController.text = _editedMovie.rating;
//       _metascoreController.text = _editedMovie.metascoreRating;
//       _criticsReviewController.text = _editedMovie.criticsReview;
//       _ageRatingController.text = _editedMovie.ageRating;
//       _lengthController.text = _editedMovie.movieLength;
//       _plotController.text = _editedMovie.plot;
//       _posterUrlController.text = _editedMovie.poster;
//       _backdropUrlController.text = _editedMovie.backdrop;
//       _genres = _editedMovie.genre;
//       _cast = _editedMovie.cast;
//       contentType = _editedMovie.contentType;
//       platform = _editedMovie.platform == null ? '' : _editedMovie.platform!;
//     }
//     _posterUrlFocusNode.addListener(_updateImageUrl);
//     _backdropUrlFocusNode.addListener(_updateBackdropImageUrl);
//     super.initState();
//   }

//   void _updateImageUrl() {
//     if (!_posterUrlFocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

//   void _updateBackdropImageUrl() {
//     if (!_backdropUrlFocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

//   void _updateActorImageUrl() {
//     if (!_actorUrlFocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

//   void _saveForm() {
//     _editedMovie = Movie(
//       poster: _editedMovie.poster,
//       backdrop: _editedMovie.backdrop,
//       title: _editedMovie.title,
//       year: _editedMovie.year,
//       numOfRatings: _editedMovie.numOfRatings,
//       metascoreRating: _editedMovie.metascoreRating,
//       criticsReview: _editedMovie.criticsReview,
//       userRating: 0,
//       rating: _editedMovie.rating,
//       genre: _genres,
//       ageRating: _editedMovie.ageRating,
//       movieLength: _editedMovie.movieLength,
//       plot: _editedMovie.plot,
//       cast: _cast,
//       isFavorite: false,
//       contentType: contentType,
//       id: widget.id,
//       platform: platform,
//     );
//     // if (widget.id != null) {
//     //   Provider.of<Movies>(context, listen: false)
//     //       .updateProduct(widget.id!, _editedMovie);
//     // } else {
//     //   Provider.of<Movies>(context, listen: false).addMovie(_editedMovie);
//     // }
//     Navigator.of(context).pop();
//   }

//   @override
//   void dispose() {
//     _titleFocusNode.dispose();
//     _titleController.dispose();
//     _yearFocusNode.dispose();
//     _yearController.dispose();
//     _ratingsQuantityFocusNode.dispose();
//     _ratingsQuantityController.dispose();
//     _imdbRatingFocusNode.dispose();
//     _imdbRatingController.dispose();
//     _criticsReviewFocusNode.dispose();
//     _criticsReviewController.dispose();
//     _metascoreFocusNode.dispose();
//     _metascoreController.dispose();
//     _ageRatingFocusNode.dispose();
//     _ageRatingController.dispose();
//     _lengthFocusNode.dispose();
//     _lengthController.dispose();
//     _plotFocusNode.dispose();
//     _plotController.dispose();
//     _posterUrlController.dispose();
//     _posterUrlFocusNode.removeListener(_updateImageUrl);
//     _posterUrlFocusNode.dispose();
//     _backdropUrlController.dispose();
//     _backdropUrlFocusNode.removeListener(_updateBackdropImageUrl);
//     _backdropUrlFocusNode.dispose();
//     _genresController.dispose();
//     _genresFocusNode.dispose();
//     _actorUrlController.dispose();
//     _actorUrlFocusNode.removeListener(_updateActorImageUrl);
//     _actorUrlFocusNode.dispose();
//     _characterFocusNode.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     Future openDialog(int? index) => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text('Add Cast Member'),
//               content: Column(
//                 children: [
//                   SimpleTextField(
//                     hintText: 'Actor Name',
//                     textInputAction: TextInputAction.next,
//                     controller: _actorNameController,
//                     onSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_characterFocusNode);
//                     },
//                   ),
//                   SimpleTextField(
//                     hintText: 'Character Name',
//                     textInputAction: TextInputAction.next,
//                     focusNode: _characterFocusNode,
//                     controller: _characterController,
//                     onSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_actorUrlFocusNode);
//                     },
//                   ),
//                   ImageTextField(
//                       imageUrlController: _actorUrlController,
//                       imageUrlFocusNode: _actorUrlFocusNode,
//                       textInputAction: TextInputAction.done,
//                       hintText: 'Actor Image URL',
//                       width: 100,
//                       height: 100),
//                   FlatButton(
//                       onPressed: () {
//                         _member = Member(
//                           originalName: _actorNameController.text,
//                           movieName: _characterController.text,
//                           image: _actorUrlController.text,
//                         );
//                         if (index != null) {
//                           _cast.removeAt(index);
//                           _cast.insert(index, _member);
//                         } else {
//                           _cast.add(_member);
//                         }
//                         Navigator.pop(context);
//                         setState(() {});
//                         _actorNameController.clear();
//                         _characterController.clear();
//                         _actorUrlController.clear();
//                       },
//                       child: Text('Save',
//                           style: Theme.of(context).textTheme.headline6)),
//                 ],
//               ),
//             ));

//     void editActor(int index) {
//       _actorNameController.text = _editedMovie.cast[index].originalName;
//       _characterController.text = _editedMovie.cast[index].movieName;
//       _actorUrlController.text = _editedMovie.cast[index].image;
//       openDialog(index);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         actions: [
//           FlatButton(
//               onPressed: _saveForm,
//               child: Text('Save',
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline6!
//                       .copyWith(color: Colors.black))),
//         ],
//       ),
//       body: Column(
//         children: [
//           ScreenTitleWidget(
//               title: widget.id != null
//                   ? 'Edit Title:\n' '${_editedMovie.title}'
//                   : 'Add Title'),
//           Expanded(
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             contentType = 'movie';
//                             setState(() {});
//                           },
//                           child: Container(
//                             width: size.width * .25,
//                             height: size.width * .2,
//                             decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 1, color: kSecondaryColor),
//                               borderRadius: BorderRadius.circular(10),
//                               color: contentType == 'movie'
//                                   ? kSecondaryColor
//                                   : Colors.white,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.movie,
//                                   color: contentType == 'movie'
//                                       ? Colors.white
//                                       : kSecondaryColor,
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'MOVIE',
//                                   style: TextStyle(
//                                     color: contentType == 'movie'
//                                         ? Colors.white
//                                         : Colors.black87,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             contentType = 'streaming';
//                             setState(() {});
//                           },
//                           child: Container(
//                             width: size.width * .25,
//                             height: size.width * .2,
//                             decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 1, color: kSecondaryColor),
//                               borderRadius: BorderRadius.circular(10),
//                               color: contentType == 'streaming'
//                                   ? kSecondaryColor
//                                   : Colors.white,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.movie,
//                                   color: contentType == 'streaming'
//                                       ? Colors.white
//                                       : kSecondaryColor,
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'STREAMING',
//                                   style: TextStyle(
//                                     color: contentType == 'streaming'
//                                         ? Colors.white
//                                         : Colors.black87,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             contentType = 'upcoming';
//                             setState(() {});
//                           },
//                           child: Container(
//                             width: size.width * .25,
//                             height: size.width * .2,
//                             decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 1, color: kSecondaryColor),
//                               borderRadius: BorderRadius.circular(10),
//                               color: contentType == 'upcoming'
//                                   ? kSecondaryColor
//                                   : Colors.white,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.movie,
//                                   color: contentType == 'upcoming'
//                                       ? Colors.white
//                                       : kSecondaryColor,
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'COMING\nSOON',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: contentType == 'upcoming'
//                                         ? Colors.white
//                                         : Colors.black87,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (contentType == 'streaming')
//                     Container(
//                       margin:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               platform = 'amazon';
//                               setState(() {});
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               width: size.width * .25,
//                               height: size.width * .2,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     width: 1,
//                                     color: platform == ''
//                                         ? Colors.grey[600]!
//                                         : platform == 'amazon'
//                                             ? Colors.grey[600]!
//                                             : Colors.grey[400]!),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Opacity(
//                                 opacity: platform == ''
//                                     ? 1
//                                     : platform == 'amazon'
//                                         ? 1
//                                         : 0.4,
//                                 child: Image(
//                                   alignment: Alignment.center,
//                                   image: AssetImage(
//                                       'assets/images/prime-video-logo-square.webp'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               platform = 'netflix';
//                               setState(() {});
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               width: size.width * .25,
//                               height: size.width * .2,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     width: 1,
//                                     color: platform == ''
//                                         ? Colors.grey[600]!
//                                         : platform == 'netflix'
//                                             ? Colors.grey[600]!
//                                             : Colors.grey[400]!),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Opacity(
//                                 opacity: platform == ''
//                                     ? 1
//                                     : platform == 'netflix'
//                                         ? 1
//                                         : 0.4,
//                                 child: Image(
//                                   alignment: Alignment.center,
//                                   image: AssetImage(
//                                       'assets/images/netflix-logo-square.png'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               platform = 'disney';
//                               setState(() {});
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               width: size.width * .25,
//                               height: size.width * .2,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     width: 1,
//                                     color: platform == ''
//                                         ? Colors.grey[600]!
//                                         : platform == 'disney'
//                                             ? Colors.grey[600]!
//                                             : Colors.grey[400]!),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Opacity(
//                                 opacity: platform == ''
//                                     ? 1
//                                     : platform == 'disney'
//                                         ? 1
//                                         : 0.4,
//                                 child: Image(
//                                   alignment: Alignment.center,
//                                   image: AssetImage(
//                                       'assets/images/disney-logo.png'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   SimpleTextField(
//                     hintText: 'Title',
//                     controller: _titleController,
//                     onSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: _editedMovie.poster,
//                           backdrop: _editedMovie.backdrop,
//                           title: value,
//                           year: _editedMovie.year,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: _editedMovie.ageRating,
//                           movieLength: _editedMovie.movieLength,
//                           plot: _editedMovie.plot,
//                           cast: _cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: contentType);
//                     },
//                     focusNode: _titleFocusNode,
//                     textInputAction: TextInputAction.next,
//                     onSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_yearFocusNode);
//                     },
//                   ),
//                   SimpleTextField(
//                     hintText: 'Year',
//                     controller: _yearController,
//                     onSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: _editedMovie.poster,
//                           backdrop: _editedMovie.backdrop,
//                           title: _editedMovie.title,
//                           year: value,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: _editedMovie.ageRating,
//                           movieLength: _editedMovie.movieLength,
//                           plot: _editedMovie.plot,
//                           cast: _editedMovie.cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: _editedMovie.contentType);
//                     },
//                     keyboardType: TextInputType.number,
//                     focusNode: _yearFocusNode,
//                     textInputAction: TextInputAction.next,
//                     onSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_imdbRatingFocusNode);
//                     },
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SimpleTextField(
//                           hintText: 'imdb Rating',
//                           controller: _imdbRatingController,
//                           onSaved: (value) {
//                             _editedMovie = Movie(
//                                 poster: _editedMovie.poster,
//                                 backdrop: _editedMovie.backdrop,
//                                 title: _editedMovie.title,
//                                 year: _editedMovie.year,
//                                 numOfRatings: _editedMovie.numOfRatings,
//                                 metascoreRating: _editedMovie.metascoreRating,
//                                 criticsReview: _editedMovie.criticsReview,
//                                 userRating: _editedMovie.userRating,
//                                 rating: value,
//                                 genre: _editedMovie.genre,
//                                 ageRating: _editedMovie.ageRating,
//                                 movieLength: _editedMovie.movieLength,
//                                 plot: _editedMovie.plot,
//                                 cast: _editedMovie.cast,
//                                 isFavorite: _editedMovie.isFavorite,
//                                 contentType: _editedMovie.contentType);
//                           },
//                           keyboardType: TextInputType.number,
//                           focusNode: _imdbRatingFocusNode,
//                           textInputAction: TextInputAction.next,
//                           onSubmitted: (_) {
//                             FocusScope.of(context)
//                                 .requestFocus(_ratingsQuantityFocusNode);
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: SimpleTextField(
//                           hintText: 'No. of Ratings',
//                           controller: _ratingsQuantityController,
//                           onSaved: (value) {
//                             _editedMovie = Movie(
//                                 poster: _editedMovie.poster,
//                                 backdrop: _editedMovie.backdrop,
//                                 title: _editedMovie.title,
//                                 year: _editedMovie.year,
//                                 numOfRatings: value,
//                                 metascoreRating: _editedMovie.metascoreRating,
//                                 criticsReview: _editedMovie.criticsReview,
//                                 userRating: _editedMovie.userRating,
//                                 rating: _editedMovie.rating,
//                                 genre: _editedMovie.genre,
//                                 ageRating: _editedMovie.ageRating,
//                                 movieLength: _editedMovie.movieLength,
//                                 plot: _editedMovie.plot,
//                                 cast: _editedMovie.cast,
//                                 isFavorite: _editedMovie.isFavorite,
//                                 contentType: _editedMovie.contentType);
//                           },
//                           keyboardType: TextInputType.number,
//                           focusNode: _ratingsQuantityFocusNode,
//                           textInputAction: TextInputAction.next,
//                           onSubmitted: (_) {
//                             FocusScope.of(context)
//                                 .requestFocus(_metascoreFocusNode);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SimpleTextField(
//                           hintText: 'Metascore',
//                           controller: _metascoreController,
//                           onSaved: (value) {
//                             _editedMovie = Movie(
//                                 poster: _editedMovie.poster,
//                                 backdrop: _editedMovie.backdrop,
//                                 title: _editedMovie.title,
//                                 year: _editedMovie.year,
//                                 numOfRatings: _editedMovie.numOfRatings,
//                                 metascoreRating: value,
//                                 criticsReview: _editedMovie.criticsReview,
//                                 userRating: _editedMovie.userRating,
//                                 rating: _editedMovie.rating,
//                                 genre: _editedMovie.genre,
//                                 ageRating: _editedMovie.ageRating,
//                                 movieLength: _editedMovie.movieLength,
//                                 plot: _editedMovie.plot,
//                                 cast: _editedMovie.cast,
//                                 isFavorite: _editedMovie.isFavorite,
//                                 contentType: _editedMovie.contentType);
//                           },
//                           keyboardType: TextInputType.number,
//                           focusNode: _metascoreFocusNode,
//                           textInputAction: TextInputAction.next,
//                           onSubmitted: (_) {
//                             FocusScope.of(context)
//                                 .requestFocus(_criticsReviewFocusNode);
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: SimpleTextField(
//                           hintText: 'Critics Reviews',
//                           controller: _criticsReviewController,
//                           onSaved: (value) {
//                             _editedMovie = Movie(
//                                 poster: _editedMovie.poster,
//                                 backdrop: _editedMovie.backdrop,
//                                 title: _editedMovie.title,
//                                 year: _editedMovie.year,
//                                 numOfRatings: _editedMovie.numOfRatings,
//                                 metascoreRating: _editedMovie.metascoreRating,
//                                 criticsReview: value,
//                                 userRating: _editedMovie.userRating,
//                                 rating: _editedMovie.rating,
//                                 genre: _editedMovie.genre,
//                                 ageRating: _editedMovie.ageRating,
//                                 movieLength: _editedMovie.movieLength,
//                                 plot: _editedMovie.plot,
//                                 cast: _editedMovie.cast,
//                                 isFavorite: _editedMovie.isFavorite,
//                                 contentType: _editedMovie.contentType);
//                           },
//                           keyboardType: TextInputType.number,
//                           focusNode: _criticsReviewFocusNode,
//                           textInputAction: TextInputAction.next,
//                           onSubmitted: (_) {
//                             FocusScope.of(context)
//                                 .requestFocus(_ageRatingFocusNode);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SimpleTextField(
//                     hintText: 'Age Rating',
//                     controller: _ageRatingController,
//                     onSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: _editedMovie.poster,
//                           backdrop: _editedMovie.backdrop,
//                           title: _editedMovie.title,
//                           year: _editedMovie.year,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: value,
//                           movieLength: _editedMovie.movieLength,
//                           plot: _editedMovie.plot,
//                           cast: _editedMovie.cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: _editedMovie.contentType);
//                     },
//                     focusNode: _ageRatingFocusNode,
//                     textInputAction: TextInputAction.next,
//                     onSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_lengthFocusNode);
//                     },
//                   ),
//                   SimpleTextField(
//                     hintText: 'Length',
//                     controller: _lengthController,
//                     onSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: _editedMovie.poster,
//                           backdrop: _editedMovie.backdrop,
//                           title: _editedMovie.title,
//                           year: _editedMovie.year,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: _editedMovie.ageRating,
//                           movieLength: value,
//                           plot: _editedMovie.plot,
//                           cast: _editedMovie.cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: _editedMovie.contentType);
//                     },
//                     focusNode: _lengthFocusNode,
//                     textInputAction: TextInputAction.next,
//                     onSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_plotFocusNode);
//                     },
//                   ),
//                   SimpleTextField(
//                     hintText: 'Plot',
//                     controller: _plotController,
//                     onSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: _editedMovie.poster,
//                           backdrop: _editedMovie.backdrop,
//                           title: _editedMovie.title,
//                           year: _editedMovie.year,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: _editedMovie.ageRating,
//                           movieLength: _editedMovie.movieLength,
//                           plot: value,
//                           cast: _editedMovie.cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: _editedMovie.contentType);
//                     },
//                     keyboardType: TextInputType.multiline,
//                     focusNode: _plotFocusNode,
//                     maxLines: 5,
//                   ),
//                   SimpleTextField(
//                     hintText: 'Genres',
//                     textInputAction: TextInputAction.next,
//                     controller: _genresController,
//                     focusNode: _genresFocusNode,
//                     onSubmitted: (genre) {
//                       setState(() {
//                         _genres.add(genre);
//                       });
//                       FocusScope.of(context).requestFocus(_genresFocusNode);
//                       _genresController.clear;
//                     },
//                   ),
//                   if (!_genres.isEmpty)
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: 20, right: 20, top: 0, bottom: 5),
//                       height: 40,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _genres.length,
//                           itemBuilder: (ctx, i) => GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _genres.removeAt(i);
//                                   });
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.symmetric(horizontal: 10),
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 10),
//                                   decoration: BoxDecoration(
//                                       color: Colors.grey[300],
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text('${_genres[i]}'),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Icon(
//                                         Icons.cancel_rounded,
//                                         size: 15,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                     ),
//                   ImageTextField(
//                     width: 100,
//                     height: 150,
//                     imageUrlController: _posterUrlController,
//                     imageUrlFocusNode: _posterUrlFocusNode,
//                     hintText: 'Poster Image URL',
//                     textInputAction: TextInputAction.next,
//                     imageSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: value,
//                           backdrop: _editedMovie.backdrop,
//                           title: _editedMovie.title,
//                           year: _editedMovie.year,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: _editedMovie.ageRating,
//                           movieLength: _editedMovie.movieLength,
//                           plot: _editedMovie.plot,
//                           cast: _editedMovie.cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: _editedMovie.contentType);
//                     },
//                   ),
//                   ImageTextField(
//                     width: 100,
//                     height: 75,
//                     imageUrlController: _backdropUrlController,
//                     imageUrlFocusNode: _backdropUrlFocusNode,
//                     hintText: 'Backdrop Image URL',
//                     textInputAction: TextInputAction.done,
//                     imageSaved: (value) {
//                       _editedMovie = Movie(
//                           poster: _editedMovie.poster,
//                           backdrop: value,
//                           title: _editedMovie.title,
//                           year: _editedMovie.year,
//                           numOfRatings: _editedMovie.numOfRatings,
//                           metascoreRating: _editedMovie.metascoreRating,
//                           criticsReview: _editedMovie.criticsReview,
//                           userRating: _editedMovie.userRating,
//                           rating: _editedMovie.rating,
//                           genre: _editedMovie.genre,
//                           ageRating: _editedMovie.ageRating,
//                           movieLength: _editedMovie.movieLength,
//                           plot: _editedMovie.plot,
//                           cast: _editedMovie.cast,
//                           isFavorite: _editedMovie.isFavorite,
//                           contentType: _editedMovie.contentType);
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: RaisedButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: BorderSide(width: 2, color: kSecondaryColor),
//                       ),
//                       onPressed: () {
//                         openDialog(null);
//                       },
//                       child: Text(
//                         'Add Cast Member',
//                         style: Theme.of(context).textTheme.headline5!.copyWith(
//                               color: kSecondaryColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                       ),
//                       color: Colors.white,
//                     ),
//                   ),
//                   if (!_cast.isEmpty)
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       height: 150,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 2, color: kSecondaryColor),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ListView.builder(
//                         itemCount: _cast.length,
//                         itemBuilder: (ctx, i) => GestureDetector(
//                           onTap: () {
//                             editActor(i);
//                           },
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               radius: 50,
//                               backgroundImage: NetworkImage(_cast[i].image),
//                             ),
//                             title: Text(
//                               _cast[i].originalName,
//                             ),
//                             subtitle: Text(
//                               _cast[i].movieName,
//                             ),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 setState(() {
//                                   _cast.removeAt(i);
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImageTextField extends StatelessWidget {
//   const ImageTextField({
//     Key? key,
//     required this.imageUrlController,
//     required this.imageUrlFocusNode,
//     required this.hintText,
//     this.textInputAction,
//     required this.width,
//     required this.height,
//     this.imageSaved,
//     this.initialValue,
//   }) : super(key: key);

//   final TextEditingController imageUrlController;
//   final FocusNode imageUrlFocusNode;
//   final String hintText;
//   final TextInputAction? textInputAction;
//   final double width;
//   final double height;
//   final Object? imageSaved;
//   final String? initialValue;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         if (imageUrlController.text.isNotEmpty)
//           Container(
//             width: width,
//             height: height,
//             margin: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
//             decoration: BoxDecoration(
//               border: Border.all(color: kSecondaryColor, width: 2),
//             ),
//             child: imageUrlController.text.isEmpty
//                 ? Text('Enter a URL')
//                 : FittedBox(
//                     child: Image.network(imageUrlController.text),
//                     fit: BoxFit.contain,
//                   ),
//           ),
//         SimpleTextField(
//           maxLines: 1,
//           hintText: hintText,
//           keyboardType: TextInputType.url,
//           textInputAction: textInputAction,
//           controller: imageUrlController,
//           focusNode: imageUrlFocusNode,
//           onSaved: imageSaved,
//           initialValue: initialValue,
//         ),
//       ],
//     );
//   }
// }

// class SimpleTextField extends StatefulWidget {
//   SimpleTextField({
//     Key? key,
//     required this.hintText,
//     this.onSaved,
//     this.focusNode,
//     this.onSubmitted,
//     this.maxLines,
//     this.keyboardType,
//     this.textInputAction,
//     this.controller,
//     this.initialValue,
//   }) : super(key: key);
//   String hintText;
//   Object? onSaved;
//   FocusNode? focusNode;
//   Object? onSubmitted;
//   int? maxLines;
//   TextInputType? keyboardType;
//   TextInputAction? textInputAction;
//   TextEditingController? controller;
//   String? initialValue;

//   @override
//   State<SimpleTextField> createState() => _SimpleTextFieldState();
// }

// class _SimpleTextFieldState extends State<SimpleTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         border: Border.all(color: kSecondaryColor, width: 1),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       child: TextFormField(
//         initialValue: widget.initialValue,
//         controller: widget.controller,
//         keyboardType: widget.keyboardType,
//         maxLines: widget.maxLines,
//         focusNode: widget.focusNode,
//         onFieldSubmitted: widget.onSubmitted as void Function(String)?,
//         textInputAction: widget.textInputAction,
//         onChanged: widget.onSaved as void Function(String?)?,
//         decoration: InputDecoration(
//           hintText: widget.hintText,
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
