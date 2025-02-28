import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class GlbModelViewer extends StatefulWidget {
  const GlbModelViewer({
    super.key,
    required this.modelPath,
    required this.onLoadStateChanged,
  });

  final String modelPath;
  final void Function(bool isLoaded) onLoadStateChanged;

  @override
  State<GlbModelViewer> createState() => GlbModelViewerState();
}

class GlbModelViewerState extends State<GlbModelViewer> {
  Flutter3DController? _controller;
  bool _isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = Flutter3DController();
    _controller?.onModelLoaded.addListener(_handleModelLoaded);
  }

  void _handleModelLoaded() {
    if (_controller?.onModelLoaded.value == true) {
      setState(() => _isModelLoaded = true);
      widget.onLoadStateChanged(true);
    }
  }

  @override
  void dispose() {
    _controller?.onModelLoaded.removeListener(_handleModelLoaded);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isModelLoaded ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Flutter3DViewer(
        controller: _controller,
        src: widget.modelPath,
        progressBarColor: Colors.transparent,
        activeGestureInterceptor: true,
        enableTouch: true,
        onProgress: (progress) => debugPrint('Loading: ${progress * 100}%'),
        onLoad: (model) {
          _controller?.playAnimation();
          if (mounted) {
            setState(() => _isModelLoaded = true);
            widget.onLoadStateChanged(true);
          }
        },
        onError: (error) => debugPrint('Error: $error'),
      ),
    );
  }

  void setCameraOrbit(double x, double y, double z) {
    _controller?.setCameraOrbit(x, y, z);
  }

  void resetCameraOrbit() {
    _controller?.resetCameraOrbit();
  }
}