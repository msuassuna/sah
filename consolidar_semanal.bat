@echo off
echo Iniciando consolidacao diaria...
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
.\git-bash.exe -c "
cd '%cd%';
git checkout --orphan new-branch
git add sazonal previsoes smap_gefs smapons tabelas ultimosDados sazonal_vazoes mapas README.md
git commit -m "Consolidou automaticamente os dados em %TIMESTAMP%" || exit 1
git branch -D main
git branch -m main
git push meu-repositorio main --force
echo Processo concluído!
"
if %errorlevel% equ 0 (
	echo Sucesso: Consolidacao concluida as 		exit
) else (
	echo Erro: Consolidacao falhou
)