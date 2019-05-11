#import <map>
#import "extends/UISwitch+Block.h"
#import "libraries/KittyMemory/MemoryPatch.hpp"


#define DELAY_BLOCK(x, f) \
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, x * NSEC_PER_SEC); \
dispatch_after(popTime, dispatch_get_main_queue(), ^(void) f)


// map variable to handle patches
static std::map <std::string, MemoryPatch> _patchesMap;
static void InitializePatchesMap()
{
  /* NULL for base executable */
  /* addresses are zero because this is just an example */

  _patchesMap["Minimap"] = MemoryPatch(NULL, /*address*/0x0, "\x20\x00\x80\xd2\xc0\x03\x5f\xd6", 8); //for example canShow function
  _patchesMap["Instant Kill"] = MemoryPatch(NULL, /*address*/0x0, "\xe0\xff\x9f\x52\xc0\x03\x5f\xd6", 8); // for example get_weaponDamage
  _patchesMap["GodMode"] = MemoryPatch(NULL, /*address*/0x0, "\xe0\xff\x9f\x52\xc0\x03\x5f\xd6", 8); // for example get_health*/
}



// we will be adding our uiview elements into app's main window
static UIWindow *getMainWindow()
{
  return [[[UIApplication sharedApplication] delegate] window];
}


// simple label with toggle
static UISwitch *createToggle(CGPoint point, NSString *name) {
   CGRect rect = CGRectMake(point.x, point.y, 210.f, 30.f);

   UILabel *label = [[UILabel alloc] initWithFrame:rect];
   label.text = name;
   label.textAlignment = NSTextAlignmentLeft;
   label.adjustsFontSizeToFitWidth = YES;
   label.numberOfLines = 0;
   label.textColor = [UIColor whiteColor];
   label.backgroundColor = [UIColor clearColor];
   [getMainWindow() addSubview:label];

   UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rect) + 5.f, rect.origin.y, 32.5f, 30.f)];
   sw.onTintColor = [UIColor redColor]; // toggle on state color
   [getMainWindow() addSubview:sw];

   return sw;
}


// library constructor (initialization)
static void __attribute__((constructor)) onLoad()
{
  // better to wait for few seconds to make sure app's UIWindow is ready
  DELAY_BLOCK(2, {
    float x = 100;
    float y = 100;

     // initialize patches map
     InitializePatchesMap();

     // loop through patches map and add toggle for each patch
     for (auto &it : _patchesMap)
     {
       NSString *patch_name = [NSString stringWithUTF8String:it.first.c_str()];
       [createToggle(CGPointMake(x, y), patch_name) handleControlEvent:^(UISwitch *sw){
	if([sw isOn]){ // toggle is on
             it.second.Modify();
           } else { // off
             it.second.Restore();
           }
	}];

       y += 35.f; // spacing for next toggle
     }

   });
}

// library destructor (clean up)
static void __attribute__((destructor)) onUnload()
{
  // loop through patches map and restore each patch
  for (auto &it : _patchesMap)
  {
    it.second.Restore();
  }
  _patchesMap.clear();
}
