# Creazione del progetto Vite
npm create vite@latest . -- --template vanilla

# Installazione di Tailwind CSS e delle dipendenze
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init

# Configurazione di postcss.config.js
$configJsContent = @"
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
"@
$configJsContent | Out-File -FilePath "./postcss.config.js" -Encoding utf8 -Force

# Rinominare postcss.config.js in postcss.config.cjs
Rename-Item -Path "./postcss.config.js" -NewName "postcss.config.cjs"

# Configurazione di tailwind.config.js
$tailwindConfigJs = @"
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,js}'],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@
$tailwindConfigJs | Out-File -FilePath "./tailwind.config.js" -Encoding utf8 -Force

# Chiede all'utente se desidera importare le classi di stile Tailwind
$importStyle = Read-Host "Vuoi importare le classi di stile? (S/N)"
if ($importStyle -eq "S") {
    $existingContent = Get-Content -Path "./style.css" -ErrorAction SilentlyContinue
    $styleCssContent = @"
/*
@tailwind base;
@tailwind components;
@tailwind utilities;
*/
$existingContent
"@
    $styleCssContent | Out-File -FilePath "./style.css" -Encoding utf8 -Force

    # Download and replace the SVG file
    $url = "https://raw.githubusercontent.com/luca-de-bar/tailwind-vite-setup/main/tailwind.svg"
    $svgPath = "./javascript.svg"  # Since javascript.svg is in the main directory
    Invoke-WebRequest -Uri $url -OutFile $svgPath
}

# Modifica specifica del colore per .logo.vanilla:hover
$cssFile = Get-Content -Path "./style.css" -ErrorAction SilentlyContinue
$updatedCssFile = $cssFile -replace "f7df1e", "1eb2f7"
$updatedCssFile | Out-File -FilePath "./style.css" -Encoding utf8 -Force

# Installazione di prettier e prettier-plugin-tailwindcss
npm install -D prettier prettier-plugin-tailwindcss

# Creazione di .prettierrc
$prettierRcContent = @"
{
  "plugins": ["prettier-plugin-tailwindcss"]
}
"@
$prettierRcContent | Out-File -FilePath "./.prettierrc" -Encoding utf8 -Force

# Installazione finale dei pacchetti npm
npm install

# Messaggio finale all'utente
Write-Host "La configurazione è completa. Puoi eseguire 'npm run dev'."
