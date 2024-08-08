@echo off
setlocal

REM Set variables for queue name, queue manager, and date
set QUEUE_NAME=your_queue_name
set QUEUE_MANAGER=your_queue_manager_name
set DATE=%date:~10,4%-%date:~4,2%-%date:~7,2%  REM Formats date as YYYY-MM-DD
set NETWORK_PATH=\\your\network\shared\path

REM Create the directory in the network shared path
set SAVE_PATH=%NETWORK_PATH%\%QUEUE_NAME%_%DATE%
md "%SAVE_PATH%"

REM Build the command for RFHUTIL
set RFHUTIL_CMD=rfhutilc.exe /qname:%QUEUE_NAME% /qmgr:%QUEUE_MANAGER% /dis /save /file:%SAVE_PATH%\%QUEUE_NAME%.xml /xml /get

REM Run the RFHUTIL command
%RFHUTIL_CMD%

REM Optionally display a message upon completion
echo Queue %QUEUE_NAME% has been saved to %SAVE_PATH%\%QUEUE_NAME%.xml

endlocal
