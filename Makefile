ARCHS = arm64
TARGET = iphone:clang:16.5:6.0

include theos/makefiles/common.mk

TOOL_NAME = pbcopy pbpaste

pbcopy_FILES = pbcopy.m
pbcopy_FRAMEWORKS = UIKit Foundation
pbcopy_CODESIGN_FLAGS = -Sentitlements.plist

pbpaste_FILES = pbpaste.m
pbpaste_FRAMEWORKS = UIKit Foundation
pbpaste_CODESIGN_FLAGS = -Sentitlements.plist

include $(THEOS_MAKE_PATH)/tool.mk
