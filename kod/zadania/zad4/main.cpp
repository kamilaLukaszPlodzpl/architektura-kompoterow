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

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200
#define _GRAPHICSOFF
#include <dos.h>
#include <stdio.h>
#include <iostream.h>

typedef unsigned char BYTE;
typedef unsigned int WORD;
typedef unsigned int UINT;
typedef unsigned long DWORD;
typedef unsigned long LONG;

unsigned char far* video_memory = (unsigned char far*) 0xA0000000L;

void setPixel(int x, int y, BYTE color)
{
    int addr = ((SCREEN_WIDTH*SCREEN_HEIGHT) - (SCREEN_WIDTH*y)) + x;
    video_memory[addr] = color;
}
BYTE getPixel(int x, int y)
{
    int addr = ((SCREEN_WIDTH*SCREEN_HEIGHT) - (SCREEN_WIDTH*y)) + x;
    return video_memory[addr];
}
void graphicsMode()
{
    REGPACK regs; 
    regs.r_ax = 0x13;
    intr(0x10, &regs);
}
void textMode()
{
    REGPACK regs; 
    regs.r_ax = 0x10;
    intr(0x10, &regs);
}
void setColorsPallete()
{
    outportb(0x03C8, 0); //rozpocznij ustawianie palety od koloru nr 0
	for (int i = 0; i < 256; i++)
	{
		outp(0x03C9,i * 63 / 255);//R
		outp(0x03C9,i * 63 / 255);//G
		outp(0x03C9,i * 63 / 255);//B
	}
}

struct BITMAPFILEHEADER
{
    UINT  bfType;//Opis formatu pliku. Musi być ‘BM’.
    DWORD bfSize;//Rozmiar pliku BMP w bajtach.
    UINT  bfReserved1;//Zarezerwowane. Musi być równe 0.
    UINT  bfReserved2;//Zarezerwowane. Musi być równe 0.
    DWORD bfOffBits;//Przesunięcie w bajtach początku danych
    //obrazu liczone od końca struktury 
};
struct BITMAPINFOHEADER
{
    DWORD biSize;//Rozmiar struktury BITMAPINFOHEADER.
    LONG  biWidth;//Szerokość bitmapy w pikselach.
    LONG  biHeight;//Wysokość bitmapy w pikselach.
    WORD  biPlanes;//Ilość płaszczyzn. Musi być 1.
    WORD  biBitCount;//Głębia kolorów w bitach na piksel.
    DWORD biCompression;//Rodzaj kompresji (0 – brak).
    DWORD biSizeImage;//Rozmiar obrazu w bajtach. Uwaga może być 0.
    LONG  biXPelsPerMeter;//Rozdzielczość pozioma w pikselach na metr.
    LONG  biYPelsPerMeter;//Rozdzielczość pionowa w pikselach na metr.
    DWORD biClrUsed;//Ilość używanych kolorów z palety.
    DWORD biClrImportant;//Ilość kolorów z palety niezbędnych do
    //wyświetlenia obrazu
};
struct RGBQUAD//Kolor palety w RGB
{
    BYTE rgbBlue;
    BYTE rgbGreen;
    BYTE rgbRed;
    BYTE rgbReserved;
};
struct SCREEN
{
    BYTE data[64000];
};
int printBitmap(const char* fileName)
{
    BITMAPFILEHEADER bmfh;
    BITMAPINFOHEADER bmih;
    FILE *bmpFile = fopen(fileName, "rb");
    if (bmpFile == NULL)
    {
        cout << "Nie udalo sie otworzyc pliku: " << fileName << " !\n";
        return 1;
    }
    fread(&bmfh, sizeof(BITMAPFILEHEADER), 1 , bmpFile);
    fread(&bmih, sizeof(BITMAPINFOHEADER), 1 , bmpFile);

    fseek(bmpFile,-64000,2);
    for(WORD i = 0; i < 64000; i++)
    {
        char color = fgetc(bmpFile);
        video_memory[63999-i] = color;
    }
    fclose(bmpFile);
    return 0;
}
void copyScreen(SCREEN &destination)
{
    for(WORD i = 0; i < 64000; i++)
    {
        destination.data[i] = video_memory[i];
    }
}
void printScreen(BYTE *src)
{
    for(WORD i = 0; i < 64000; i++)
    {
        video_memory[i] = src[i];
    }
}
int main()
{
    char *fileName = "boat.bmp";
    cout << "Podaj nazwe pliku: ";
    //cin >> fileName;
    cout << "\n";
    graphicsMode();
    setColorsPallete();
    printBitmap(fileName);

    SCREEN screenCopy;
    copyScreen(screenCopy);

    char c = 'e';
    do
    {
        c = cin.get();
        switch(c)
        {
            case 'e':
                textMode();
                return 0;
            case 'm':
                textMode();
                graphicsMode();
                break;
        }
    }while(c != 'e');
    textMode();
   return 0;
}