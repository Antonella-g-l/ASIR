# Scripts Bash: procesos, señales, prioridades y parámetros

## 1. Procesos y PID

Un proceso es un programa que se está ejecutando en el sistema.

Cada proceso tiene un número identificador llamado **PID (Process ID)**.

Para consultar los procesos que están ejecutándose se puede utilizar:

```bash
ps
```

También podemos buscar un proceso concreto con:

```bash
pgrep nombre
```

Si queremos que el nombre coincida exactamente:

```bash
pgrep -x nombre
```

Por ejemplo:

```bash
pgrep -x firefox
```

`pgrep` devuelve el PID del proceso encontrado.

Otra opción es:

```bash
pidof firefox
```

`pidof` muestra el PID o los PID asociados a un programa.

---

## 2. Variables

Una variable sirve para guardar un valor y poder utilizarlo después.

Por ejemplo:

```bash
programa="firefox"
```

Para utilizar el contenido de la variable:

```bash
$programa
```

Por ejemplo:

```bash
echo "$programa"
```

mostraría:

```text
firefox
```

### Guardar el resultado de un comando

Con `$(...)` podemos ejecutar un comando y guardar su resultado en una variable:

```bash
pid=$(pgrep -x "$programa")
```

Se puede entender como:

> Ejecuta `pgrep -x` y guarda el resultado en `pid`.

---

## 3. Parámetros del script

Los parámetros son datos que se pueden pasar al ejecutar un script.

```bash
$1
```

es el primer parámetro.

```bash
$2
```

es el segundo.

```bash
$3
```

es el tercero.

Por ejemplo:

```bash
./script.sh procesos.csv
```

En este caso:

```text
$1 = procesos.csv
```

Podemos guardar ese parámetro en una variable:

```bash
archivo="$1"
```

Esto significa:

> Guarda en la variable `archivo` el contenido del primer parámetro.

Para comprobar si se ha indicado el primer parámetro:

```bash
if [ -z "$1" ]; then
    echo "ERROR: Debes indicar un archivo."
    exit 1
fi
```

`-z` comprueba si una cadena está vacía.

---

## 4. Condicionales

La estructura básica de un `if` es:

```bash
if [ condición ]; then
    comandos
else
    comandos
fi
```

Se puede leer como:

> Si se cumple la condición, haz esto. Si no, haz lo otro.

### Comparaciones numéricas

| Operador | Significado   |
| -------- | ------------- |
| `-eq`    | igual         |
| `-ne`    | distinto      |
| `-lt`    | menor que     |
| `-gt`    | mayor que     |
Ejemplo:

```bash
```
Significa:
> Si la señal es menor que 0.

### OR

Ejemplo:

if [ "$señal" -lt 0 ] || [ "$señal" -gt 64 ]; then
```

Se puede leer:


### `-z` y `-n`
```bash
-z "$variable"
```


```bash
-n "$variable"
```

Comprueba si la variable NO está vacía.
Por ejemplo:

```bash
if [ -n "$pid" ]; then
```

Significa:

> Si `pid` NO está vacío.

---

## 5. Comprobar archivos

Para comprobar si existe un archivo normal:

```bash
[ -f "$archivo" ]
```

Si queremos comprobar que NO existe:

```bash
if [ ! -f "$archivo" ]; then
```

`!` significa **NOT / NO**.

Se puede leer:

> Si el archivo NO existe.

---

## 6. `exit`

`exit` termina la ejecución del script.

Por ejemplo:

```bash
exit 1
```

se suele utilizar cuando ha ocurrido un error.

Ejemplo:

```bash
if [ ! -f "$archivo" ]; then
    echo "ERROR: El archivo no existe."
    exit 1
fi
```

Primero muestra el error y después termina el script.

---

## 7. Usuario administrador y `$UID`

`$UID` contiene el identificador del usuario actual.

El usuario `root` tiene:

```text
UID = 0
```

Por eso podemos comprobar si el script se está ejecutando como administrador:

```bash
if [ $UID -ne 0 ]; then
    echo "ERROR: Debes ejecutar este script como administrador."
    exit 1
fi
```

`-ne` significa **distinto de**.


Comprueba si la variable está vacía.

> Si la señal es menor que 0 O mayor que 64.
```bash
Se puede leer:


`||` significa **O**.
> Si el UID es distinto de 0, muestra un error y termina.



if [ "$señal" -lt 0 ]; then

| `-ge`    | mayor o igual |
---

## 8. `read`


`read` permite pedir un dato al usuario y guardarlo en una variable.


```bash
read -p "Introduce el nombre: " programa

```


El usuario escribe el nombre y se guarda en:


```text
$programa
```


---


## 9. Señales y `kill`


Los procesos pueden recibir señales.

El comando:

```bash

kill
```


sirve para enviar una señal a un proceso.

No significa necesariamente "matar" el proceso.


Por ejemplo:


```bash
kill -15 1234
```


envía la señal 15 al proceso cuyo PID es `1234`.


La señal 15 (`SIGTERM`) solicita normalmente que el proceso termine de forma ordenada.


También existe:


```bash
kill -0 1234
```


La señal 0 no termina el proceso. Se puede utilizar para comprobar si el proceso existe y si tenemos permisos para enviarle señales.

---


## 10. Comprobar si un comando funciona


Un comando puede utilizarse directamente en un `if`:

```bash
if kill -"$señal" "$pid"; then
    echo "La señal se ha enviado correctamente."
else
    echo "No se pudo enviar la señal."
fi
```

Se puede entender como:

> Intenta ejecutar el comando. Si funciona correctamente, entra en `then`. Si falla, entra en `else`.

---

## 11. Bucles `while`

`while` permite repetir una serie de instrucciones mientras se cumpla una condición.

También podemos utilizarlo para leer un archivo línea por línea.

Ejemplo:

```bash
while IFS=',' read -r programa prioridad
do
    echo "$programa"
    echo "$prioridad"
done < "$archivo"
```

Aquí el `while` lee el archivo línea por línea.

---

## 12. `IFS` y archivos CSV

Un archivo CSV puede tener datos separados por comas:

```text
firefox,5
gedit,-10
gimp,0
```

Con:

```bash
IFS=','
```

indicamos que la coma será el separador.

Por eso:

```bash
read -r programa prioridad
```

puede guardar:

```text
firefox → programa
5       → prioridad
```

`-r` hace que `read` lea el texto sin interpretar caracteres especiales como la barra invertida.

---

## 13. Redirección `<`

La redirección:

```bash
< "$archivo"
```

hace que el contenido del archivo se utilice como entrada del comando.

Por ejemplo:

```bash
done < "$archivo"
```

se puede entender como:

> Haz que el `while` lea las líneas del archivo.

---

## 14. `nice`

`nice` permite iniciar un programa con un determinado nivel de prioridad.

Ejemplo:

```bash
nice -n 5 firefox
```

El programa se inicia con un valor `nice` de 5.

De forma general:

* Un valor `nice` más bajo → mayor prioridad.
* Un valor `nice` más alto → menor prioridad.

---

## 15. `renice`

`renice` permite cambiar el valor `nice` de un proceso que ya está ejecutándose.

Ejemplo:

```bash
renice 5 -p 1234
```

Cambia el valor `nice` del proceso con PID `1234` a `5`.

La diferencia principal es:

```text
nice     → iniciar un proceso con una prioridad determinada
renice   → cambiar la prioridad de un proceso que ya existe
```

---

## 16. Ejecutar un proceso en segundo plano

El símbolo:

```bash
&
```

hace que el proceso se ejecute en segundo plano.

Ejemplo:

```bash
firefox &
```

El terminal puede continuar utilizando comandos mientras el programa se está ejecutando.

---

## 17. `$!`

`$!` contiene el PID del último proceso que se ha ejecutado en segundo plano.

Ejemplo:


