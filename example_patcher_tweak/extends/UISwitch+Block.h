#ifndef UISwitchBlock_h
#define UISwitchBlock_h

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void (^SwitchActionBlock)(UISwitch *);

@interface UISwitch(Block)

- (void) handleControlEvent:(SwitchActionBlock)action;

@end

#endif
