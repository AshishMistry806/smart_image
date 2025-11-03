# Smart Image

A powerful and customizable image widget for Flutter that supports:
✅ Network, Asset, File & SVG images  
✅ Name initials fallback (Avatar support)  
✅ Dynamic initials text style  
✅ Shimmer, BlurHash & Fade-in animations  
✅ Tooltip + Semantics for accessibility  
✅ Circle + Rounded shapes  
✅ Border radius + Background color + Padding  
✅ Error placeholder support  
✅ Cached images for better performance

---

## 📸 Preview

<p align="center">
  <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/188052156/508810839-c9ad3c4c-ba3b-4e71-89c5-f1ead77cc138.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20251103%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20251103T062246Z&X-Amz-Expires=300&X-Amz-Signature=b1d6fcb3d9b70f79e814a2ab9f65f565c6bac0ac896d07177844ee15e37b076a&X-Amz-SignedHeaders=host" width="300" />
</p>

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  smart_image: ^1.0.5
```

---

## 🚀 Usage

### ✅ Basic Usage – Network Image
```dart
SmartImage(
  imageUrl: "https://example.com/profile.jpg",
  height: 80,
  width: 80,
  borderRadius: 12,
)
```

### ✅ Fallback: Initials Avatar – Circular
```dart
SmartImage(
  name: "Ashish Mistry",
  width: 80,
  height: 80,
  useNameAsFallback: true,
  backgroundColor: Colors.purple,
  textColor: Colors.white,
)
```

### ✅ Rounded Initials + Dynamic TextStyle
```dart
SmartImage(
  name: "Smart Image",
  width: 80,
  height: 80,
  initialsShape: AvatarShape.rounded,
  borderRadius: 12,
  initialsTextStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  useNameAsFallback: true,
)
```

### ✅ BlurHash Placeholder + Cached Image
```dart
SmartImage(
  imageUrl: "https://example.com/photo.png",
  blurHash: "LEHV6nWB2yk8pyo0adR*.7kCMdnj",
  loadingAnimation: LoadingAnimation.blurhash,
  width: 80,
  height: 80,
)
```

---

## ✨ Feature Support Table

| Feature                     | Support |
| --------------------------- | :-----: |
| Network image               |    ✅    |
| Asset image                 |    ✅    |
| File image                  |    ✅    |
| SVG support                 |    ✅    |
| Initials fallback           |    ✅    |
| Dynamic initials text style |    ✅    |
| Shimmer placeholder         |    ✅    |
| BlurHash placeholder        |    ✅    |
| Fade-in animation           |    ✅    |
| Cached image                |    ✅    |

---

## 📝 License
This package is available under the MIT License.

---

### ❤️ You can support this package by ⭐ starring it on GitHub!
