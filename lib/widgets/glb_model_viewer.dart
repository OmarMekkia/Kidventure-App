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
    
    // Add a timeout to ensure we don't wait forever
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isModelLoaded) {
        setState(() => _isModelLoaded = true);
        widget.onLoadStateChanged(true);
      }
    });
  }

  void _handleModelLoaded() {
    if (_controller?.onModelLoaded.value == true && !_isModelLoaded) {
      setState(() => _isModelLoaded = true);
      widget.onLoadStateChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flutter3DViewer(
      controller: _controller,
      src: widget.modelPath,
      progressBarColor: Colors.transparent,
      activeGestureInterceptor: true,
      enableTouch: true,
      onProgress: (progress) {
        debugPrint('Loading: ${progress * 100}%');
        // If progress is near completion, consider the model loaded
        if (progress > 0.95 && !_isModelLoaded) {
          setState(() => _isModelLoaded = true);
          widget.onLoadStateChanged(true);
        }
      },
      onLoad: (model) {
        _controller?.playAnimation();
        if (mounted && !_isModelLoaded) {
          setState(() => _isModelLoaded = true);
          widget.onLoadStateChanged(true);
        }
      },
      onError: (error) {
        debugPrint('Error: $error');
        // Even on error, we should hide the loading indicator
        if (mounted && !_isModelLoaded) {
          setState(() => _isModelLoaded = true);
          widget.onLoadStateChanged(true);
        }
      },
    );
  }

  void setCameraOrbit(double x, double y, double z) {
    _controller?.setCameraOrbit(x, y, z);
  }

  void resetCameraOrbit() {
    _controller?.resetCameraOrbit();
  }
}