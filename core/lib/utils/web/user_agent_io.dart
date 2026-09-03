/// Non-web platforms never call [userAgent] (guarded by `PlatformInfo.isWeb`
/// at every call site), so this just satisfies the conditional-export
/// contract without pulling in a web-only package.
String get userAgent => '';
