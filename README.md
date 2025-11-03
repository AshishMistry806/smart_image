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
  <img src="https://drive.google.com/file/d/1pRkqeemMI1rJUArPBpVPVgDMi3HnJXb_/view?usp=sharing" width="300" />
</p>

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  smart_image: ^1.0.0
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
