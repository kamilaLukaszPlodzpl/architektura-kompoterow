echo Compile file %1
tasm %1.asm
tlink %1.obj
td %1.exe