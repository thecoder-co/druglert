import 'dart:typed_data';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class CloudinarySdk {
  static final cloudinary = Cloudinary.full(
    apiKey: '847692665635857',
    apiSecret: 'JfnDTnzuP_V-wvr4wHGP_n8NhZ0',
    cloudName: 'dahba1joi',
  );

  static Future<String?> uploadFile({required Uint8List fileBytes}) async {
    final response =
        await cloudinary.unsignedUploadResource(CloudinaryUploadResource(
      uploadPreset: 'hsxp50rg',
      fileBytes: fileBytes,
      resourceType: CloudinaryResourceType.raw,
    ));

    return response.secureUrl;
  }
}
