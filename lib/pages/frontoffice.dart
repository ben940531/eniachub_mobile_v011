import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FrontOfficePage extends StatefulWidget {
  static const String routeName = '/frontoffice';
  final String name;
  final String connectionId;
  final CameraDescription camera;

  const FrontOfficePage({
    Key key,
    @required this.name,
    @required this.connectionId,
    @required this.camera,
  }) : super(key: key);

  @override
  _FrontOfficePageState createState() => _FrontOfficePageState();
}

class _FrontOfficePageState extends State<FrontOfficePage> {
  //CameraController _cameraController;
 // Future<void> _initializeContorllerFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   _cameraController = CameraController(
  //     widget.camera,
  //     ResolutionPreset.medium,
  //   );

  //   //_initializeContorllerFuture = _cameraController.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FrontOfficeTabPage(camera: widget.camera),
    );
  }

  // @override
  // void dispose() {
  //   _cameraController.dispose();
  //   super.dispose();
  // }
}

class FrontOfficeTabPage extends StatefulWidget {
  final CameraDescription camera;
  const FrontOfficeTabPage({
    Key key,
    @required this.camera,
  });

  @override
  _FrontOfficeTabPageState createState() => _FrontOfficeTabPageState();
}

class _FrontOfficeTabPageState extends State<FrontOfficeTabPage> {
  CameraController _cameraController;
  Future<void> _initializeContorllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeContorllerFuture = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Front office page'),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.check)),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          DataTable(columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Number')),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('12345')),
            ]),
          ]),
          FutureBuilder<void>(
            future: _initializeContorllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_cameraController);
              } else {
                // Otherwise, display a loading indicator.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          // You must wait until the controller is initialized before displaying the
// camera preview. Use a FutureBuilder to display a loading spinner until the
// controller has finished initializing.
        ],
      ),
      floatingActionButton: DefaultTabController.of(context).index == 1
          ? FloatingActionButton(
              child: Icon(Icons.camera_alt),
              // Provide an onPressed callback.
              onPressed: () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  await _initializeContorllerFuture;

                  // Construct the path where the image should be saved using the path
                  // package.
                  final path = join(
                    // Store the picture in the temp directory.
                    // Find the temp directory using the `path_provider` plugin.
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.png',
                  );

                  // Attempt to take a picture and log where it's been saved.
                  await _cameraController.takePicture(path);
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
            )
          : null,
      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Stack(children: [
      //           Positioned(
      //               child: Text(
      //                 this.name,
      //                 style: TextStyle(fontSize: 18.0, color: Colors.white),
      //               ),
      //               bottom: 12.0),
      //         ]),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
