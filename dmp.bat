@echo off
setlocal

REM Set variables for queue name, queue manager, and date
set QUEUE_NAME=your_queue_name
set QUEUE_MANAGER=your_queue_manager_name
set DATE=%date:~10,4%-%date:~4,2%  REM Formats date as YYYY-MM-DD
set NETWORK_PATH=\\your\network\shared\path

REM Create the directory in the network shared path
set SAVE_PATH=%NETWORK_PATH%\%QUEUE_NAME%_%DATE%
md "%SAVE_PATH%"

REM Dump the messages from the queue to a file
dmpmqmsg -m %QUEUE_MANAGER% -i %QUEUE_NAME% -f "%SAVE_PATH%\%QUEUE_NAME%.xml"

REM Check if the dump was successful before clearing the queue
if %ERRORLEVEL% EQU 0 (
    echo Messages successfully dumped to %SAVE_PATH%\%QUEUE_NAME%.xml
    REM Clear the messages from the queue by dumping them to NUL (a null device)
    dmpmqmsg -m %QUEUE_MANAGER% -i %QUEUE_NAME% -o NUL
    if %ERRORLEVEL% EQU 0 (
        echo Messages successfully cleared from %QUEUE_NAME%
    ) else (
        echo Error clearing messages from %QUEUE_NAME%
    )
) else (
    echo Error dumping messages from %QUEUE_NAME%
)

endlocal
