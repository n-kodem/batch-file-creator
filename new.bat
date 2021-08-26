@ECHO OFF

echo.

:: PARSING DATA
if "%1%"=="f" goto masscreator
if "%1%" == "" goto noarg
if "%1%" == "webh" goto webh
if "%1%" == "webp" goto webp
if "%1%" == "webt" goto webt

if "%1%" == "pyt" goto pyt
if "%1%" == "pytl" goto pytl

if "%1%" == "cpp" goto cpp
if "%1%" == "cppl" goto cppl
if "%1%"=="cppc" goto masscreator

if "%1%" == "list" goto list

:: IF NO DATA MATCH
echo Provided argument doesn't exist
EXIT 0

:: RANDOM FILE CREATOR
:masscreator
::if "%2%"=="" goto noarg
:: ITERATING THROUGHT ARGS
for %%x in (%*) do (
   :: For not first arg
   if not %%~x==%1 (
        :: if user command was f - files creating
        if "%1%" == "f" (

          set arg = %%~x
          set arg|find "." >nul && (
          
          type NUL>%%~x
          
          ) || (
          
             echo Provided filename ^(%%~x^) haven't got an extension.
          
          )

        )

       :: if user command was cpp classes creator
       if "%1%" == "cppc" (
          set arg = %%~x

          type NUL>%%~x-fwd.h
          (
          echo ^#pragma once
          echo namespace std
          echo ^{
          echo class MyClass^;
          echo ^}
          ) > %%~x-fwd.h

          type NUL>%%~x.h
          (
          echo ^#pragma once
          echo ^#include ^"%%~x-fwd.h^"
          echo namespace std
          echo ^{
          echo class MyClass^{
          echo.
          echo ^}^;
          echo ^}
          ) > %%~x.h

          type NUL>%%~x.cpp
          (
          echo ^#include ^"%%~x.h^"
          echo namespace std
          echo.
          ) > %%~x.cpp

       
       )
   )
)
goto end

:: HTML WEB PROJECT
:webh

:: WILD FILE CREATING WITH DATA INJECTION
type nul >index.html
(
echo ^<^!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo ^<script src^=^"code.js^"^>^<^/script^>
echo ^<style rel^=^"stylesheet^" type^=^"text^/css^" href^=^"style.css^"^>^<^/style^>
echo ^<^/head^>
echo ^<body^>
echo.
echo ^<^/body^>
echo ^<^/html^>
)> index.html

type nul >style.css
type nul >code.js

goto end

:: PHP WEB PROJECT
:webp

type nul >index.php
type nul >style.css
type nul >code.js

goto end

:: JS TEST PROJECT
:webt

type nul >index.html

(
echo ^<^!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo ^<script src^=^"code.js^"^>^<^/script^>
echo ^<^/head^>
echo ^<body^>
echo.
echo ^<^/body^>
echo ^<^/html^>
)> index.html

type nul >code.js

goto end

:: BASIC PYTHON PROJECT
:pyt
type nul >"main.py"

goto end

:: PYTHON PROJECT WITH FUNCTIONS IN OTHER FILE
:pytl
type nul>"main.py"

(
   echo import functions.py
   echo.
)> main.py

type nul>"functions.py"

goto end

:: BASIC CPP PROJECT
:cpp

type nul>main.cpp

goto end

:: CPP PROJECT WITH FUNCTIONS IN OTHER FILE
:cppl

type nul>main.cpp

(
   echo ^#include ^"functions^.cpp^"
   echo ^#include ^<iostream^>
   echo.
   echo namespace std
   echo.
   echo int main^(^)^{
   echo.
   echo ^}^;
)> main.cpp

type nul>functions.cpp

goto end

:: COMMANDS LISTING
:list
echo List of commands:
echo.
echo WEB DEV:
echo.
echo webh - index.html code.js style.css
echo webp - index.php code.js style.css
echo webt - index.php code.js
echo.
echo PY DEV:
echo.
echo pyt - main.py
echo pyl - main.py functions.py
echo.
echo CPP DEV:
echo.
echo cpp - main.cpp
echo cppl - functions.cpp
echo cppc args... - creates cpp classes
echo.
echo OTHER:
echo f args... - creates custom file example: new f readme.md 
goto end

:: IF NO ARGS
:noarg
echo No argument provided
EXIT 0

:end
echo.
echo Command worked succesfully!
