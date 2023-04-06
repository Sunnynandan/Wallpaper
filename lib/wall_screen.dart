import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class WallScreen extends StatefulWidget {
  static String wall_screen = "wallscreen/";
  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  void setWallpaper(String url, String mode) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      if (mode == "home") {
        await AsyncWallpaper.setWallpaperFromFile(
            filePath: file.path, wallpaperLocation: AsyncWallpaper.HOME_SCREEN);
      }
      if (mode == "lock") {
        await AsyncWallpaper.setWallpaperFromFile(
            filePath: file.path, wallpaperLocation: AsyncWallpaper.LOCK_SCREEN);
      }
      if (mode == "both") {
        await AsyncWallpaper.setWallpaperFromFile(
            filePath: file.path,
            wallpaperLocation: AsyncWallpaper.BOTH_SCREENS);
      }
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageUrl = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
          title: Text("Wallpaper",
              style: GoogleFonts.raleway(
                  fontSize: 35, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                icon: const Icon(Icons.wallpaper),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      title: const Center(
                          child: Text(
                        "Choose the Screen",
                      )),
                      actions: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () =>
                                      {setWallpaper(imageUrl, "home")},
                                  child: const Text(
                                    "Homescreen",
                                  )),
                              TextButton(
                                  onPressed: () =>
                                      {setWallpaper(imageUrl, "lock")},
                                  child: const Text("Lockscreen")),
                              TextButton(
                                  onPressed: () =>
                                      {setWallpaper(imageUrl, "both")},
                                  child: const Text("Both"))
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                label: Text(
                  "Homescreen",
                  style: GoogleFonts.roboto(fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
