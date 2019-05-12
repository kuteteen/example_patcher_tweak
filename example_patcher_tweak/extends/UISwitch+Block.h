//refs to https://cnbin.github.io/blog/2016/03/16/uibutton-plus-blockde-shi-yong/.

#ifndef UISwitchBlock_h
#define UISwitchBlock_h

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void (^SwitchActionBlock)(UISwitch *);

@interface UISwitch(Block)

- (void) handleControlEvent:(SwitchActionBlock)action;

@end

#endif
