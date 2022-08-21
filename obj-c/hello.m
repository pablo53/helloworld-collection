#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *helloText = @"Hello, World!\n";
        printf("%s", [helloText UTF8String]);
    }
    return 0;
}
