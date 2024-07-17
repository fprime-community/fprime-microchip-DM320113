## Changes to F Prime Files

To successfully build and generate the F Prime `xc32_toolchain`, the following changes were made:

1. **BasicTypes.hpp**
   - Disabled IEEE-754 checks for the `xc32` compiler.

2. **PlatformTypes.h**
   - Modified to use a 32-bit bus size as required by the `xc32` compiler.

These changes are necessary to ensure compatibility with the `xc32` compiler and the target hardware.

