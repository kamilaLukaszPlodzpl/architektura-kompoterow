//;=============================================================================;
//;                                                                             ;
//; Plik           : MAIN.CPP                                                   ;
//; Format         : EXE                                                        ;
//; Cwiczenie      : Ćwiczenie 3. Program hybrydowy                             ;
//; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
//; Data zaliczenia: DD.MM.YYYY                                                 ;
//; Uwagi          :                                                            ;
//;                                                                             ;
//;=============================================================================;

/*
 * Zrobić wprowadzanie danych
 */

#include <iostream.h>

extern "C" double arrayAvg(double tab[], int n);
extern "C" int countChar(char *tab, char searchedChar);

int main()
{
    cout
    << "Wybierz wariant\n"
    << "1. Srednia wartosc z elementow tablicy\n"
    << "2. Ilosc wystapien danego znaku w ciagu znakow\n"
    ;

    int selectedFunction = -1;
    while(selectedFunction != 1 && selectedFunction != 2)
    {
        cout << "Podaj numer funkcji: ";
        cin >> selectedFunction;
    }

    switch(selectedFunction)
    {
        case 1://Srednia z elementow tablicy
            int n = 0;
            cout << "Podaj rozmiar tablicy: \n";
            cin >> n;
            cout << "podaj n elementow tablicy oddzielonych bialym znakiem: \n";
            double *tab = new double [n];
            for ( int i = 0; i < n; i++)
            {
                cin >> tab[i];
            }
            double resultAvg = arrayAvg(tab,n);
            cout << "Srednia z elementow tablicy to: "<< resultAvg << '\n';
            break; 
        case 2://Ilosc wystapien danego znaku
            char *str;
            cout << "Podaj napis: \n";
            cin >> str;
            char find;
            cout << "Jakiego znaku szukac: \n";
            cin >> find;
            int resultChar = countChar(str, find);
            cout << "Ilosc wystapien znaku \"" << find << "\" wynosi: " << resultChar;
            break;
    }
    return 0;
}