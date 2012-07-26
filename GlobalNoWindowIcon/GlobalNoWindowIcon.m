//
//  GlobalNoWindowIcon.m
//  GlobalNoWindowIcon
//
//  Created by inket on 25/07/2012.
//  Copyright (c) 2012 inket. All rights reserved.
//

#import "GlobalNoWindowIcon.h"

static GlobalNoWindowIcon* plugin = nil;

@implementation NSObject (GlobalNoWindowIcon)

#pragma mark Method replacement

- (void)new_drawWithFrame:(struct CGRect)arg1 inView:(id)arg2 {
    [self new_drawWithFrame:NSMakeRect(arg1.origin.x, arg1.origin.y, arg1.size.width-20, arg1.size.height)
                     inView:arg2];
}

@end

@implementation GlobalNoWindowIcon

#pragma mark SIMBL methods and loading

+ (GlobalNoWindowIcon*)sharedInstance {
	if (plugin == nil)
		plugin = [[GlobalNoWindowIcon alloc] init];
	
	return plugin;
}

+ (void)load {
	[[GlobalNoWindowIcon sharedInstance] loadPlugin];
    
	NSLog(@"GlobalNoWindowIcon loaded.");
}

- (void)loadPlugin {
    Class class = NSClassFromString(@"NSThemeDocumentButtonCell");
    Method new = class_getInstanceMethod(class, @selector(new_drawWithFrame:inView:));
    Method old = class_getInstanceMethod(class, @selector(drawWithFrame:inView:));
	method_exchangeImplementations(new, old);

    for (NSWindow *window in [[NSApplication sharedApplication] windows])
            [window display];
}

@end
