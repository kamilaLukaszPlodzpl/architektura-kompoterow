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

BITMAPFILEHEADER bmfh;
BITMAPINFOHEADER bmih;


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
int printBitmap(const char* fileName)
{
    FILE *bmpFile = fopen(fileName, "rb");
    if (bmpFile == NULL)
    {
        cout << "Nie udalo sie otworzyc pliku: " << fileName << " !\n";
        return 1;
    }
    fread(&bmfh, sizeof(BITMAPFILEHEADER), 1 , bmpFile);
    fread(&bmih, sizeof(BITMAPINFOHEADER), 1 , bmpFile);
    LONG size =  bmih.biWidth * bmih.biHeight;
    fseek(bmpFile,-size,2);
    for(WORD i = 0; i < size; i++)
    {
        char color = fgetc(bmpFile);
        video_memory[(size-1)-i] = color;
    }
    fclose(bmpFile);
    return 0;
}


int main()
{
	WORD i = 0;
    char *fileName = "boat.bmp";
    cout << "Podaj nazwe pliku: ";
    cin >> fileName;
    cout << "\n";
    graphicsMode();
    setColorsPallete();
    printBitmap(fileName);

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
                cout << "0. Wyjdz\n";
                cout << "1. Zmien obrazek\n";
                cout << "2. Normalny obraz\n";
                cout << "3. Negatyw\n";
                cout << "4. Rozjasnij/Przyciemnij\n"; 
                cout << "5. Progowanie\n";
                int selectFunction = -1;
                cin >> selectFunction;
                LONG size =  bmih.biWidth * bmih.biHeight;
                switch(selectFunction)
                {
                    case 0://Wyjdz
                        textMode();
                        return 0;
                    case 1:
                        cout << "Podaj nazwe plik: ";
                        cin >> fileName;
    		            graphicsMode();
						setColorsPallete();
						printBitmap(fileName);
                        break;
                	case 2://Normalnie
    		            graphicsMode();
						setColorsPallete();
						printBitmap(fileName);
                		break;
                	case 3://Negatyw
                        graphicsMode();
                        setColorsPallete();
                        printBitmap(fileName);
                        for(i = 0; i < size; i++)
                        {
                            video_memory[i] = ~video_memory[i];
                        }
                		break;
                    case 4://Rosjasnienie
                        cout << "Wartosci dodatnie rozjasniaja, ujemne przyciemniaja. Podaj wartosc:\n";
                        int value3;
                        cin >> value3;
                        graphicsMode();
                        setColorsPallete();
                        printBitmap(fileName);
                        for(i =0; i < size; i++)
                        {
                            int x = video_memory[i];
                            x += value3;
                            if(x > 255)
                                x = 255;
                            else if(x < 0)
                                x = 0;
                            video_memory[i] = x;
                        }
                        break;
                    case 5:
                        cout << "Podaj wartosc progu\n";
                        BYTE value4;
                        cin >> value4;
                        graphicsMode();
                        setColorsPallete();
                        printBitmap(fileName);
                        for(i = 0; i < size; i++)
                        {
                            if(video_memory[i] < value4)
                            {
                                video_memory[i] = 0;
                            }
                        }
                        break;
				}
                break;
        }
    }while(c != 'e');
    textMode();
   return 0;
}