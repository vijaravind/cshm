% test_BSP_arg
% @author : Mathias, Dyma

% clc; clear all; close all;

% Ahmed size measurements
P = [19.2 10 29 37 37 27.5 38.9 45.5 22 18 26 12 14.5 26 17 27 27.5 34 ... 
    25 36 8 25 38.5 38 58 60 101 94.5 91.5 104 11 6 10 3 19 34 31 30 ... 
    35 30 56.5].';
M = 75;

arg = bsp_arg(P, M);
