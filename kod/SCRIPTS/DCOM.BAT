echo Compile file %1
tasm %1.asm
tlink /t %1.obj
td %1.com