import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/model/movie_detail_response.dart';
import 'package:youtube_downloader/repo/movie_repo.dart';

class MovieDetailsBloc {
  final movieRepo = MovieRepository();
  final BehaviorSubject<MovieDetailResponse> _subject = BehaviorSubject<MovieDetailResponse>();

  BehaviorSubject<MovieDetailResponse> get subject => _subject;

  getMovieDetail(int id)async {
    MovieDetailResponse response = await movieRepo.getMovieDetail(id);
    _subject.sink.add(response);
  }


  dispose(){
    subject.close();
  }
}