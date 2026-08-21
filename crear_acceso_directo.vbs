' ============================================================
'  crear_acceso_directo.vbs
'  Crea un ícono en el Escritorio que abre la App con un
'  doble clic, sin mostrar barra de direcciones ni pestañas
'  (modo "aplicación" del navegador).
'
'  INSTRUCCIONES ANTES DE USARLO:
'  1. Copia esta carpeta completa (con chrome_proxy.exe,
'     index.html, app.ico, etc.) al equipo de cada usuario,
'     por ejemplo en:  C:\JuntaDirectiva\
'  2. Ajusta las 3 líneas marcadas con ">>>" más abajo.
'  3. Haz doble clic en este archivo UNA sola vez.
'     Aparecerá el ícono en el Escritorio, listo para usar.
' ============================================================

Set oWS = WScript.CreateObject("WScript.Shell")

' >>> 1. Carpeta donde está instalada la App (sin barra al final)
appFolder = "C:\JuntaDirectiva"

' >>> 2. Nombre del acceso directo que verá el usuario
shortcutName = "Junta Directiva.lnk"

' >>> 3. Archivo html que se debe abrir
htmlFile = appFolder & "\index.html"

desktopPath = oWS.SpecialFolders("Desktop")
Set oLink = oWS.CreateShortcut(desktopPath & "\" & shortcutName)

' Abre chrome_proxy.exe en "modo aplicación": sin barra de
' direcciones, sin pestañas, como si fuera un programa normal.
oLink.TargetPath = appFolder & "\chrome_proxy.exe"
oLink.Arguments = "--app=""file:///" & Replace(htmlFile, "\", "/") & """"
oLink.WorkingDirectory = appFolder
oLink.IconLocation = appFolder & "\app.ico"
oLink.Description = "Abrir Junta Directiva"
oLink.WindowStyle = 1
oLink.Save

MsgBox "Listo. El ícono ya está en el Escritorio.", vbInformation, "Instalación completa"
