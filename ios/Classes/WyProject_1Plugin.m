#import "WyProject_1Plugin.h"
#if __has_include(<wy_project_1/wy_project_1-Swift.h>)
#import <wy_project_1/wy_project_1-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wy_project_1-Swift.h"
#endif

@implementation WyProject_1Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWyProject_1Plugin registerWithRegistrar:registrar];
}
@end
