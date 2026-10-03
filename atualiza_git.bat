@echo off
echo Iniciando processo...
cd /d "%~dp0" 
echo Diretório Atual %cd%

if exist ".git\index.lock" del /F /Q ".git\index.lock">nul
if exist ".git\HEAD.lock" del /F /Q ".git\HEAD.lock">nul

set ANO=%date:~-4%
set MES=%date:~-7,2%
set DIA=%date:~-10,2%
set HORA=%time:~0,2%
set MIN=%time:~3,2%

set TIMESTAMP=%ANO%-%MES%-%DIA% %HORA%:%MIN%

echo Executando comando Git...
.\git-bash.exe -c"
cd '%cd%';
echo 'Pasta atual: $(pwd)';
git status
git add sazonal previsoes smap_gefs smapons tabelas ultimosDados sazonal_vazoes mapas
git commit -m "As pastas atualizaram automaticamente - %TIMESTAMP%"
git push meu-repositorio main
echo Concluído!
if %errorlevel% equ 0 exit
"