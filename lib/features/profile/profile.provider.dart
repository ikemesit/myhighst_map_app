import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());
// final pickedImageProvider = StateProvider<XFile?>((ref) => null);
final pickedImageProvider = StateProvider<File?>((ref) => null);
