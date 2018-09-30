# Activamos la politica de ejecución para nuestro actual usuario (así podremos ejecutar el script), para ello copiamos el siguiente comando en powershell:
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
# Para más información https://technet.microsoft.com/es-ES/library/hh847748.aspx

# Vemos quien somos, cortamos y metemos en una variable
$usuario = whoami
$corte = $usuario.IndexOf("\")
$usuario1 = $usuario.Substring($corte+1)

# Comprobamos la existencia del directorio Youtube
$directorio = "C:\Users\$usuario1\Desktop\Youtube"
$Comprobacion = Test-Path $directorio 

#Si no existe, descargamos y descomprimimos los archivos necesarios

If ($Comprobacion -eq $False) {

    # Creamos el directorio Youtube en el escritorio
    cd "C:\Users\$usuario1\Desktop\"
    mkdir Youtube

    # Definimos la url del archivo youtube-dl y su directorio.
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $url = "https://github.com/rg3/youtube-dl/releases/download/2018.09.26/youtube-dl.exe"
    $path = "C:\Users\$usuario1\Desktop\Youtube\youtube-dl.exe"

    $youtube = New-Object System.Net.WebClient
    $youtube.DownloadFile($url, $path)

    # Definimos la url del convertidor ffmpeg y su directorio.

    $url1 = "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20180930-b577153-win64-static.zip"
    $path1 = "C:\Users\$usuario1\Desktop\Youtube\ffmpeg-20180930-b577153-win64-static.zip"

    $ffmpeg = New-Object System.Net.WebClient
    $ffmpeg.DownloadFile($url1, $path1)

    # Descomprimos el zip
    Expand-Archive "C:\Users\$usuario1\Desktop\Youtube\ffmpeg-20180930-b577153-win64-static.zip" -DestinationPath "C:\Users\$usuario1\Desktop\Youtube\"

    # Movemos los ejecutables dentro del directorio Bin al directorio padre Youtube.
    Move-Item "C:\Users\$usuario1\Desktop\Youtube\ffmpeg-20180930-b577153-win64-static\bin\*" "C:\Users\$usuario1\Desktop\Youtube\"

    #Eliminamos el directorio resultante de la descomprención y el fichero .zip
    cd "C:\Users\$usuario1\Desktop\Youtube"
    rm ffmpeg-20180930-b577153-win64-stati* -Recurse -Force

    # Preguntamos por la url a descargar
    $video = Read-Host -Prompt "Pega la URL"

    $ruta = pwd
    $posicionpredeterminada = "C:\Users\$usuario1\Desktop\Youtube\"

    If ($ruta -eq $posicionpredeterminada) {
    
        # Ejecutamos youtube-dl
        .\youtube-dl.exe --extract-audio --audio-format mp3 --audio-quality 0 $video
    }
    else {
        cd "C:\Users\$usuario1\Desktop\Youtube\"
        # Ejecutamos youtube-dl
        .\youtube-dl.exe --extract-audio --audio-format mp3 --audio-quality 0 $video
    }
}
else {

    # Preguntamos por la url a descargar
    $video = Read-Host -Prompt "Pega la URL"

    $ruta = pwd
    $posicionpredeterminada = "C:\Users\$usuario1\Desktop\Youtube\"

    If ($ruta -eq $posicionpredeterminada) {
    
        # Ejecutamos youtube-dl
        .\youtube-dl.exe --extract-audio --audio-format mp3 --audio-quality 0 $video
    }
    else {
        cd "C:\Users\$usuario1\Desktop\Youtube\"
        # Ejecutamos youtube-dl
        .\youtube-dl.exe --extract-audio --audio-format mp3 --audio-quality 0 $video
    }
}
#>