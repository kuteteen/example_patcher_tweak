CFLAGS = -fobjc-arc
ARCHS = arm64
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = example_patcher_tweak

example_patcher_tweak_CCFLAGS = -std=c++11 -fno-rtti -DNDEBUG -w

example_patcher_tweak_FILES = Tweak.xm \
$(wildcard libraries/KittyMemory/*.cpp) \
$(wildcard extends/*/*.m)

example_patcher_tweak_FRAMEWORKS = UIKit

example_patcher_tweak_LIBRARIES += substrate

include $(THEOS_MAKE_PATH)/tweak.mk
