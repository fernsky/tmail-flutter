/// Non-web platforms never call this (guarded by `PlatformInfo.isWeb` at
/// the only call site), so it just satisfies the conditional-export
/// contract without pulling in a web-only package.
void printToWebConsole(String level, String value) {}
