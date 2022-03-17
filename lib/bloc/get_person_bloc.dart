import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/model/movie_response.dart';
import 'package:youtube_downloader/model/person_response.dart';
import 'package:youtube_downloader/repo/movie_repo.dart';

class PersonListBloc {
  final movieRepo = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
  BehaviorSubject<PersonResponse>();

  BehaviorSubject<PersonResponse> get subject => _subject;

  getNowPlaying() async {
    PersonResponse response = await movieRepo.getPersons();
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }
}
