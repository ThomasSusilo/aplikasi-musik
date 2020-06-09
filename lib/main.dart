import 'package:flutter/material.dart';
import 'music_player_screen.dart';

void main() => runApp(App());

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF7D9AFF),
        accentColor: Color(0xFF7D9AFF),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Song> listSong = List();

  @override
  void initState() {
    initListSong();
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldState,
      body: Stack(
        children: <Widget>[
          _buildWidgetAlbumCover(mediaQuery),
          _buildWidgetActionAppBar(mediaQuery),
          _buildWidgetArtistName(mediaQuery),
          _buildWidgetFloatingActionButton(mediaQuery),
          _buildWidgetListSong(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetListSong(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        top: mediaQuery.size.height / 1.8 + 48.0,
        right: 20.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: Column(
        children: <Widget>[
          _buildWidgetHeaderSong(),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                Song song = listSong[index];
                return GestureDetector(
                  onTap: () {
                   _navigatorToMusicPlayerScreen(song.title);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          song.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 9.0,
                            fontFamily: 'Campton_Light',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        song.duration,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 9.0,
                        ),
                      ),
                      SizedBox(width: 24.0),
                      Icon(Icons.more_horiz, color: Colors.grey,),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              itemCount: listSong.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetHeaderSong() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Popular',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            fontFamily: 'Campton_Light',
          ),
        ),
        Text(
          'Show all',
          style: TextStyle(
            color: Color(0xFF7D9AFF),
            fontWeight: FontWeight.w600,
            fontFamily: 'Campton_Light',
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetAlbumCover(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48.0),
        ),
        image: DecorationImage(
          image: AssetImage('assets/matana.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildWidgetActionAppBar(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: mediaQuery.padding.top + 16.0,
        right: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetArtistName(MediaQueryData mediaQuery) {
    return SizedBox(
      height: mediaQuery.size.height / 1.8,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                Positioned(
                  child: Text(
                    'University',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CoralPen',
                      fontSize: 24.0,
                    ),
                  ),
                  top: constraints.maxHeight - 45.0,
                ),
                Positioned(
                  child: Text(
                    'Matana',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CoralPen',
                      fontSize: 24.0,
                    ),
                  ),
                  top: constraints.maxHeight - 70.0,
                ),
                Positioned(
                  child: Text(
                    'Tranding',
                    style: TextStyle(
                      color: Color(0xFF7D9AFF),
                      fontSize: 14.0,
                      fontFamily: 'Campton_Light',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  top: constraints.maxHeight - 90.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWidgetFloatingActionButton(MediaQueryData mediaQuery) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: mediaQuery.size.height / 1.8 - 32.0,
          right: 32.0,
        ),
        child: FloatingActionButton(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF7D9AFF),
          onPressed: () {
            _navigatorToMusicPlayerScreen(listSong[0].title);
          },
        ),
      ),
    );
  }

  void _navigatorToMusicPlayerScreen(String title) {
    Navigator.of(scaffoldState.currentContext)
      .push(MaterialPageRoute(builder: (context) {
        return MusicPlayerScreen(title);
    }));
  }

  void initListSong() {
      listSong.add(Song(title: 'Untitled, 2014', duration:   '3:49'));
      listSong.add(Song(title: 'Surat Cinta Untuk Starla', duration: '4:34'));
      listSong.add(Song(title: 'Aloha', duration: '4:11'));
  }
}

class Song {
  String title;
  String duration;

  Song({this.title, this.duration});

  @override
  String toString() {
    return 'Song{title: $title, duration: $duration}';
  }
}