import 'package:youtube_downloader/bloc/get_now_playing.dart';

import 'get_genre_bloc.dart';
import 'get_movie_bloc.dart';
import 'get_movies_by_genre.dart';
import 'get_person_bloc.dart';

final movieListBloc = MovieListBloc();
final genreBloc = GenreBloc();
final playingMoviesBloc = PlayingMovies();
final movieListByGenreBloc = MovieListByGenreBloc();
final personListBloc = PersonListBloc();