echo Compile file %1
tasm %1.asm
tlink %1.obj
del %1.obj
del %1.map
%1.exe