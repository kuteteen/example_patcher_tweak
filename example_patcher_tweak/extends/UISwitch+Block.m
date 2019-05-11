#import "UISwitch+Block.h"

@implementation UISwitch(Block)

static char overviewKey;


- (void)handleControlEvent:(SwitchActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventValueChanged];
}


- (void)callActionBlock:(id)sender {
    SwitchActionBlock block = (SwitchActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(sender);
    }
}

@end
