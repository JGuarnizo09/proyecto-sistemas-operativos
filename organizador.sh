#!/bin/bash
# Organizador automático de archivos (versión autocontenida para Debian)
# Crea sus propios archivos de prueba y luego los clasifica por extensión.
# Solo usa comandos que ya trae Debian: no hay que instalar nada.

# 1. Carpeta de prueba dentro de tu carpeta personal
CARPETA="$HOME/PruebaDescargas"

# Si ya existía de una ejecución anterior, la borramos para empezar limpio
rm -rf "$CARPETA"
mkdir -p "$CARPETA"

# 2. Creamos archivos de mentira para la demostración
touch "$CARPETA/foto.jpg" "$CARPETA/logo.png" "$CARPETA/informe.pdf"
touch "$CARPETA/tarea.docx" "$CARPETA/cancion.mp3" "$CARPETA/video.mp4"
touch "$CARPETA/comprimido.zip" "$CARPETA/script.sh" "$CARPETA/otro.xyz"

echo "Archivos de prueba creados en: $CARPETA"
echo ""

# 3. Revisamos cada elemento de la carpeta, uno por uno
for archivo in "$CARPETA"/*; do

    # Solo nos interesan los archivos (no las carpetas)
    if [ -f "$archivo" ]; then

        # Obtenemos solo el nombre (sin la ruta completa)
        nombre=$(basename "$archivo")

        # 4. case: según cómo termine el nombre, elegimos el destino
        case "$nombre" in
            *.jpg|*.jpeg|*.png|*.gif)   destino="Imagenes" ;;
            *.pdf|*.doc|*.docx|*.txt)   destino="Documentos" ;;
            *.mp3|*.wav)                destino="Musica" ;;
            *.mp4|*.avi|*.mkv)          destino="Videos" ;;
            *.zip|*.tar|*.gz|*.rar)     destino="Comprimidos" ;;
            *.sh|*.py|*.c)              destino="Programas" ;;
            *)                          destino="Otros" ;;
        esac

        # 5. Creamos la subcarpeta si no existe y movemos el archivo
        mkdir -p "$CARPETA/$destino"
        mv "$archivo" "$CARPETA/$destino/"

        echo "Movido: $nombre  ->  $destino"
    fi
done

echo ""
echo "¡Listo! Estos son los resultados:"
ls -R "$CARPETA"