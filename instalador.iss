; ============================================================
;  instalador.iss
;  Script para Inno Setup (gratis: https://jrsoftware.org/isinfo.php)
;
;  Qué hace: genera UN solo archivo "Instalar_JuntaDirectiva.exe".
;  Cuando un usuario le da doble clic e "Siguiente, Siguiente,
;  Instalar", el programa:
;    - copia la App a su computadora
;    - crea el ícono en el Escritorio automáticamente
;    - crea el acceso también en el Menú Inicio
;  El usuario NO necesita saber nada de tecnología.
;
;  CÓMO USARLO:
;  1. Instala Inno Setup en una PC con Windows (gratis).
;  2. Copia en una misma carpeta: index.html, chrome_proxy.exe,
;     app.ico, este archivo instalador.iss, y cualquier otro
;     archivo que use tu App (css, imágenes, js, etc).
;  3. Abre este archivo con Inno Setup y pulsa "Compilar".
;  4. Te generará Instalar_JuntaDirectiva.exe: ese es el único
;     archivo que debes enviar a cada persona de la junta.
; ============================================================

[Setup]
AppName=Junta Directiva
AppVersion=1.0
DefaultDirName={autopf}\JuntaDirectiva
DefaultGroupName=Junta Directiva
DisableProgramGroupPage=yes
OutputBaseFilename=Instalar_JuntaDirectiva
SetupIconFile=app.ico
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=lowest
; Ícono grande y claro durante la instalación:
WizardStyle=modern

[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

; Copia TODOS los archivos de la App (ajusta si tienes subcarpetas,
; ej. "css\*", "img\*", agregando más líneas Source)
[Files]
Source: "index.html"; DestDir: "{app}"; Flags: ignoreversion
Source: "chrome_proxy.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "app.ico"; DestDir: "{app}"; Flags: ignoreversion
; Source: "css\*"; DestDir: "{app}\css"; Flags: ignoreversion recursesubdirs

; Crea el ícono en el Escritorio y en el Menú Inicio, apuntando
; a chrome_proxy.exe en modo "aplicación" (sin barra de direcciones).
[Icons]
Name: "{autodesktop}\Junta Directiva"; Filename: "{app}\chrome_proxy.exe"; \
    Parameters: "--app=""file:///{app}\index.html"""; \
    IconFilename: "{app}\app.ico"; WorkingDir: "{app}"

Name: "{group}\Junta Directiva"; Filename: "{app}\chrome_proxy.exe"; \
    Parameters: "--app=""file:///{app}\index.html"""; \
    IconFilename: "{app}\app.ico"; WorkingDir: "{app}"

; Al terminar la instalación, ofrece abrir la App de una vez
[Run]
Filename: "{app}\chrome_proxy.exe"; Parameters: "--app=""file:///{app}\index.html"""; \
    Description: "Abrir Junta Directiva ahora"; Flags: nowait postinstall skipifsilent
