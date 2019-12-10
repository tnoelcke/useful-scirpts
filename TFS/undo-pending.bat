ECHO OFF
SET workspace=%1
SET name=%2
SET tempfile=.\temp.txt

ECHO "Finding Pending Changes..."
ECHO tf stat /workspace:%workspace%;%name% 
tf stat /workspace:%workspace%;%name% > %tempfile%

FOR /f "tokens=5,6 delims= " %%a in (%tempfile%) DO (
    echo "-----------------------------------------------------------------------------------------------"
    IF "%%b"=="" (
        IF NOT "%%a"=="" (
            ECHO tf undo /workspace:%workspace%;%name% %%a
            tf undo /workspace:%workspace%;%name% %%a
        )
    )
    IF NOT "%%b"=="" (
        IF NOT "%%b"=="path" (
            ECHO tf undo /workspace:%workspace%;%name% %%a
            tf undo /workspace:%workspace%;%name% %%b
        )
    )
)

del /f %tempfile%

