//;=============================================================================;
//;                                                                             ;
//; Plik           : MAIN.CPP                                                   ;
//; Format         : EXE                                                        ;
//; Cwiczenie      : Ćwiczenie 4. Tryb graficzny                                ;
//; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
//; Data zaliczenia: DD.MM.YYYY                                                 ;
//; Uwagi          :                                                            ;
//;                                                                             ;
//;=============================================================================;

#include <dos.h>

int main()
{
    REGPACK regs; 
    regs.r_ax = 0x13;
    intr(0x10, &regs);
    
    unsigned char *video_memory = (byte *)0xA0000000L;
    //ustaw lewy górny piksel obrazu na kolor 128
    //aktualnej palety karty VGA 
    video_memory[0] = 128;
    //ustaw prawy dolny piksel obrazu na kolor 255
    //aktualnej palety karty VGA 
    video_memory[64000] = 255;

    outportb(0x03C8, 0);
    //rozpocznij ustawianie palety od koloru nr 0
    for (int i = 0; i < 255; i++)
    //ilość kolorów w palecie 8-bitowej
    {
        outp(0x03C9, palette[i].rgbRed   * 63 / 255);
        //skalowana składowa R
        outp(0x03C9, palette[i].rgbGreen * 63 / 255);
        //skalowana składowa
        outp(0x03C9, palette[i].rgbBlue  * 63 / 255);
        //skalowana składowa B
    }

    return 0;
}