﻿Stend
=====
12
Набор скриптов и функция на Matlab для стенда робофутбола.

Инструкция к запуску:
1)Запустите SSL-vision и настройте цвета для распознования.
2)Запустите клиент-серверное приложение
3)Подключите роботов к BtModul или larcmacs
4)Укажите пусть к рабочей дирректории скриптов 
5)Проверте работоспособность контура. (например строчкой в мейке Rule(0,50,-50,0,0,0);)
6)Определите шапки выших роботов. Можно посмотреть при помощи команды MAP_INI или в консоле в виде массивов Yellows и Blues
7)запустите режим автомотического нахождения пары PairStart(); или укажите номера контроля роботов в шапке main (например:RP.Yellow(4).Nrul=1; RP.Blue(6).Nrul=3;)
7)Назначьте роли для каждого робота. Примеры голкиперов и нападающих предоставленны в main
8)Всё должно работать. Следите за изменяющимся освещением и вылетающим за пределы поля мячиком.


Для запуска демонстрации введите 
main
clear all
MOD()