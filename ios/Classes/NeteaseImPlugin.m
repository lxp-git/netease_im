#import "NeteaseImPlugin.h"
#if __has_include(<netease_im/netease_im-Swift.h>)
#import <netease_im/netease_im-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "netease_im-Swift.h"
#endif

@implementation NeteaseImPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNeteaseImPlugin registerWithRegistrar:registrar];
}
@end
