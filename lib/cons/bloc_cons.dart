import 'package:youtube_downloader/bloc/get_cast_bloc.dart';
import 'package:youtube_downloader/bloc/get_movie_details.dart';
import 'package:youtube_downloader/bloc/get_now_playing.dart';

import '../bloc/get_genre_bloc.dart';
import '../bloc/get_movie_bloc.dart';
import '../bloc/get_movies_by_genre.dart';
import '../bloc/get_person_bloc.dart';

final movieListBloc = MovieListBloc();
final movieDetailBloc = MovieDetailsBloc();
final movieCasts = CastBloc();
final genreBloc = GenreBloc();
final playingMoviesBloc = PlayingMovies();
final movieListByGenreBloc = MovieListByGenreBloc();
final personListBloc = PersonListBloc();