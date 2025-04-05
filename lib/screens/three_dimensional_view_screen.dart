import 'package:flutter/material.dart';

import '../models/camera_position.dart';
import '../models/celestial_body.dart';
import '../widgets/celestial_info_overlay.dart';
import '../widgets/glb_model_viewer.dart';
import '../widgets/obj_model_viewer.dart';
import '../widgets/starry_background.dart';

class ThreeDimensionalViewPage extends StatefulWidget {
  const ThreeDimensionalViewPage({
    super.key,
    required this.modelPath,
    required this.celestialBody,
    this.scale = 5.0,
    this.cameraPosition = const CameraPosition(0, 0, 10),
  });

  final String modelPath;
  final CelestialBody celestialBody;
  final double scale;
  final CameraPosition cameraPosition;

  @override
  State<ThreeDimensionalViewPage> createState() =>
      _ThreeDimensionalViewPageState();
}

class _ThreeDimensionalViewPageState extends State<ThreeDimensionalViewPage> {
  final GlobalKey<GlbModelViewerState> _glbViewerKey = GlobalKey();
  bool _isModelLoaded = false;
  bool _isLoading = true;

  bool get _isGlbModel => widget.modelPath.toLowerCase().endsWith('.glb');

  @override
  void initState() {
    super.initState();
    // No need to call _initializeModel here as we'll handle loading state in onLoadStateChanged
  }

  // Replace the _initializeModel method with this improved version
  void _initializeModel() async {
    // Add a timeout in case the model loading takes too long
    await Future.delayed(const Duration(seconds: 3));
    if (mounted && !_isModelLoaded) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "عرض ثلاثي الأبعاد",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(child: _buildModelViewer()),
        floatingActionButton: _isGlbModel ? _buildControlPanel() : null,
      ),
    );
  }

  Widget _buildModelViewer() {
    return Stack(
      fit: StackFit.expand,
      children: [
        const RepaintBoundary(child: StarryBackground()),
        if (_isGlbModel)
          Center(
            child: GlbModelViewer(
              key: _glbViewerKey,
              modelPath: widget.modelPath,
              onLoadStateChanged: (isLoaded) {
                setState(() {
                  _isModelLoaded = isLoaded;
                  _isLoading = !isLoaded; // Hide loading indicator when model is loaded
                });
              },
            ),
          )
        else
          Center(
            child: ObjModelViewer(
              modelPath: widget.modelPath,
              scale: widget.scale,
              cameraPosition: widget.cameraPosition,
            ),
          ),
        if (_isLoading) _buildLoadingIndicator(),
        CelestialInfoOverlay(
          celestialBody: widget.celestialBody,
          isVisible: _isModelLoaded || !_isGlbModel,
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            Text(
              "جاري تحميل النموذج...",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(
          Icons.camera_alt,
          _setCameraOrbit,
          "تغيير زاوية الكاميرا",
        ),
        _buildIconButton(
          Icons.cameraswitch,
          _resetCamera,
          "إعادة ضبط الكاميرا",
        ),
      ],
    );
  }

  Widget _buildIconButton(
    IconData icon, [
    VoidCallback? action,
    String? tooltip,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Tooltip(
        message: tooltip ?? "",
        child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: _isModelLoaded ? action : null,
        ),
      ),
    );
  }

  void _setCameraOrbit() =>
      _glbViewerKey.currentState?.setCameraOrbit(20, 20, 5);

  void _resetCamera() => _glbViewerKey.currentState?.resetCameraOrbit();
}
