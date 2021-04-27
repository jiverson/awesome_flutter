# File Selector Example

Simplest file selector. [Example](https://github.com/flutter/plugins/tree/master/packages/file_selector/file_selector/example)

## Setup

Project files are not checked in, simply run:

```bash
flutter create .
flutter run
```

Add to `macos/Runner/Release.entitlements`:

```xml
<key>com.apple.security.files.user-selected.read-only</key>
<true/>
```