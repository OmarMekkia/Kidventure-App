import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

class _ThreeDimensionalViewPageState extends State<ThreeDimensionalViewPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<GlbModelViewerState> _glbViewerKey = GlobalKey();
  bool _isModelLoaded = false;
  bool _isLoading = true;
  double _currentZoom = 5.0;
  static const double _minZoom = 2.0;
  static const double _maxZoom = 15.0;
  double _rotationX = 0.0;
  double _rotationY = 0.0;

  bool get _isGlbModel => widget.modelPath.toLowerCase().endsWith('.glb');

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Immediately start loading non-GLB models
    if (!_isGlbModel) {
      Future.microtask(() {
        if (mounted) {
          setState(() {
            _isModelLoaded = true;
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("3D View", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(child: _buildModelViewer()),
      floatingActionButton: _isModelLoaded ? _buildControlPanel() : null,
    );
  }

  Widget _buildModelViewer() {
    return Stack(
      fit: StackFit.expand,
      children: [
        const RepaintBoundary(child: StarryBackground()),
        if (_isGlbModel)
          Center(
            child: GestureDetector(
              onScaleUpdate: _handleScaleUpdate,
              child: GlbModelViewer(
                key: _glbViewerKey,
                modelPath: widget.modelPath,
                onLoadStateChanged: _handleModelLoadState,
              ),
            ),
          )
        else
          Center(
            child: GestureDetector(
              onScaleUpdate: _handleScaleUpdate,
              child: ObjModelViewer(
                modelPath: widget.modelPath,
                scale: widget.scale,
                cameraPosition: widget.cameraPosition,
              ),
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

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (_isGlbModel && _isModelLoaded) {
      // Handle zoom
      final newZoom = (_currentZoom / details.scale).clamp(_minZoom, _maxZoom);
      if (newZoom != _currentZoom) {
        setState(() {
          _currentZoom = newZoom;
        });
        _glbViewerKey.currentState?.setZoom(_currentZoom);
      }
    }
  }

  void _handleModelLoadState(bool isLoaded) {
    if (mounted && isLoaded != _isModelLoaded) {
      setState(() {
        _isModelLoaded = isLoaded;
        _isLoading = !isLoaded;
      });
    }
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              "assets/lotties/loading_model.json",
              width: 200,
              height: 200,
            ),
            const Text(
              "Loading 3D Model...",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(Icons.zoom_in, _zoomIn),
              const SizedBox(width: 8),
              _buildIconButton(Icons.zoom_out, _zoomOut),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(Icons.rotate_left, _rotateLeft),
              const SizedBox(width: 8),
              _buildIconButton(Icons.rotate_right, _rotateRight),
            ],
          ),
          const SizedBox(height: 8),
          _buildIconButton(Icons.refresh, _resetCamera),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, [VoidCallback? action]) {
    return FloatingActionButton(
      heroTag: icon.codePoint.toString(),
      mini: true,
      backgroundColor: Colors.black87,
      onPressed: action,
      child: Icon(icon, color: Colors.white),
    );
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom - 1.0).clamp(_minZoom, _maxZoom);
    });
    _glbViewerKey.currentState?.setZoom(_currentZoom);
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom + 1.0).clamp(_minZoom, _maxZoom);
    });
    _glbViewerKey.currentState?.setZoom(_currentZoom);
  }

  void _rotateLeft() {
    setState(() {
      _rotationX -= 15;
    });
    _glbViewerKey.currentState?.rotateModel(_rotationX, _rotationY);
  }

  void _rotateRight() {
    setState(() {
      _rotationX += 15;
    });
    _glbViewerKey.currentState?.rotateModel(_rotationX, _rotationY);
  }

  void _resetCamera() {
    setState(() {
      _currentZoom = 5.0;
      _rotationX = 0.0;
      _rotationY = 0.0;
    });
    _glbViewerKey.currentState?.resetCameraOrbit();
  }
}
