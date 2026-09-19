#!/bin/bash

if [ -z "$1" ]; then
    echo "ERROR: Debes indicar un archivo CSV."
    exit 1
fi

archivo="$1"

if [ ! -f "$archivo" ]; then
    echo "ERROR: El archivo no existe."
    exit 1
fi

while IFS=',' read -r programa prioridad
do
    pid=$(pgrep -x "$programa")

    if [ -n "$pid" ]; then
        if renice "$prioridad" -p "$pid"; then
            echo "Proceso $programa (PID $pid) - nice cambiado a $prioridad"
        else
            echo "Proceso $programa - ERROR: No se pudo cambiar el nice."
        fi
    else
        nice -n "$prioridad" "$programa" &
        pid=$!

        if [ $? -eq 0 ]; then
            echo "Proceso $programa (PID $pid) - nuevo proceso con nice $prioridad"
        else
            echo "Proceso $programa - ERROR: No se pudo iniciar el proceso."
        fi
    fi

done < "$archivo"
