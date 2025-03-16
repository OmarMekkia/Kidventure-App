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

  bool get _isGlbModel => widget.modelPath.toLowerCase().endsWith('.glb');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildModelViewer(),
      floatingActionButton: _isGlbModel ? _buildControlPanel() : null,
    );
  }

  Widget _buildModelViewer() {
    return Stack(
      fit: StackFit.expand,
      children: [
        const RepaintBoundary(child: StarryBackground()),
        if (_isGlbModel)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: GlbModelViewer(
                key: _glbViewerKey,
                modelPath: widget.modelPath,
                onLoadStateChanged:
                    (isLoaded) => setState(() => _isModelLoaded = isLoaded),
              ),
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
        CelestialInfoOverlay(
          celestialBody: widget.celestialBody,
          isVisible: _isModelLoaded || !_isGlbModel,
        ),
      ],
    );
  }

  Widget _buildControlPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(Icons.camera_alt, _setCameraOrbit),
        _buildIconButton(Icons.cameraswitch, _resetCamera),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, [VoidCallback? action]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: IconButton(
        icon: Icon(icon),
        onPressed: _isModelLoaded ? action : null,
      ),
    );
  }

  void _setCameraOrbit() =>
      _glbViewerKey.currentState?.setCameraOrbit(20, 20, 5);

  void _resetCamera() => _glbViewerKey.currentState?.resetCameraOrbit();
}
