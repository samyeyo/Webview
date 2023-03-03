# | Webview for LuaRT - Widget to render HTML/JS/CSS using Microsoft Edge WebView2
# | Luart.org, Copyright (c) Tine Samir 2022.
# | See Copyright Notice in LICENSE.TXT
# |--------------------------------------------------------------
# | Makefile
# | Please set LUART_PATH to your LuaRT folder if autodetection fails
# | WARNING : x86 platform is NOT supported
# |--------------------------------------------------------------
# | Usage (default release build)			 : make
# | Usage (debug build) 		  			 : make debug
# | Usage (clean all)	 				 	 : make clean
# |-------------------------------------------------------------


#---- LuaRT installation path (set it manually if autodetection fails)
LUART_PATH=D:\Github\LuaRT

MODULE=Webview
VERSION=0.5

ifeq ($(filter clean,$(MAKECMDGOALS)),)
ifeq ($(LUART_PATH),)
LUART_PATH=$(shell luart.exe -e "print(sys.registry.read('HKEY_CURRENT_USER', 'Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\LuaRT', 'InstallLocation', false) or '')"  2>nul)
endif

ifeq ($(PLATFORM),)
PLATFORM=$(shell $(LUART_PATH)\bin\luart.exe -e "print(_ARCH) " 2>nul)
endif

ifeq ($(PLATFORM),x86)
ARCH = -m32 -march=pentium4 -msse -msse2 -mmmx -fno-unwind-tables -fno-asynchronous-unwind-tables 
endif

ifeq ($(PLATFORM),x64)
ARCH = -m64 -mavx2 -mfma -fno-unwind-tables -fno-asynchronous-unwind-tables
endif

ifeq ($(LUART_PATH),)
$(info > LuaRT is not installed on this computer)
$(info > Please set the LuaRT installation path manually in the Makefile, or download and install the LuaRT toolchain)
$(error )
endif
endif


LUART_INCLUDE = -I$(LUART_PATH)\include -I./WebView/include
LUART_LIB = -L$(LUART_PATH)\lib 

BUILD := release

cflags.release = $(ARCH) -shared -s -Os -mfpmath=sse -mieee-fp -DLUART_TYPE=__decl(dllimport) -D__MINGW64__ -D_WIN32_WINNT=0x0700 $(LUART_INCLUDE) -static-libgcc -static-libstdc++ -fno-rtti -fno-exceptions -fdata-sections -ffunction-sections -fipa-pta -ffreestanding -fno-stack-check -fno-ident -fomit-frame-pointer -Wl,--gc-sections -Wl,--build-id=none -Wl,-O1 -Wl,--as-needed -Wl,--no-insert-timestamp -Wl,--no-seh
ldflags.release= -s -Wl,--no-insert-timestamp $(LUART_LIB)
cflags.debug = $(ARCH) -shared -g -O0 -mfpmath=sse -mieee-fp -DDEBUG -D__MINGW64__ -D_WIN32_WINNT=0x0700 $(LUART_INCLUDE)
ldflags.debug= $(LUART_LIB)

CC= gcc
CFLAGS := ${cflags.${BUILD}}
LDFLAGS := ${ldflags.${BUILD}}
LIBS= -llua54 -lcomctl32 -lole32 -lversion
RM= del /Q
CP= copy /Y

default: all

all: $(MODULE).dll

$(MODULE).dll: src/webview.cpp src/handler.cpp src/WebView2Loader.cpp
	@$(LUART_PATH)\bin\luart -e "require('console').writecolor('blue', '--------------- Building $(MODULE) for LuaRT $(PLATFORM)\n')"
	$(CXX) $(CFLAGS) $^ $(LDFLAGS) $(LIBS) -o $@
	@$(LUART_PATH)\bin\luart -e "require('console').writecolor('blue', '--------------- Successfully built $(MODULE) for LuaRT $(PLATFORM)\n')"

debug:
	@$(MAKE) "BUILD=debug"

.PHONY: clean all

install: all
	@$(CP) $(MODULE).dll $(LUART_PATH)\modules

package: all
	@$(LUART_PATH)\bin\luart -e "local zip=require('compression').Zip('$(MODULE)-$(VERSION)-$(PLATFORM).zip','write');zip:write('Webview.dll');zip:write('LICENSE');zip:write('README.md');zip:write('examples', 'examples')"

clean:
	@$(RM) $(MODULE).dll  2>nul
	@$(RM) $(MODULE)-$(VERSION)-$(PLATFORM).zip  2>nul
