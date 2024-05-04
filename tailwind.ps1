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

# Importazione automatica delle classi di stile Tailwind
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

# Modifica specifica del colore per .logo.vanilla:hover
$cssFile = Get-Content -Path "./style.css" -ErrorAction SilentlyContinue
$updatedCssFile = $cssFile -replace "f7df1e", "1eb2f7"
$updatedCssFile | Out-File -FilePath "./style.css" -Encoding utf8 -Force

# Modifica il link in main.js
$jsFile = Get-Content -Path "./main.js" -ErrorAction SilentlyContinue
$updatedJsFile = $jsFile -replace "https://developer.mozilla.org/en-US/docs/Web/JavaScript", "https://tailwindcss.com/docs/utility-first"
$updatedJsFile | Out-File -FilePath "./main.js" -Encoding utf8 -Force

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

# Esecuzione automatica di npm run dev
Write-Host "Setting up your development environment..."
Start-Sleep -Seconds 3  # Optional: Delay to allow background tasks to complete
npm run dev

# Messaggio finale all'utente
Write-Host "Your Vite and Tailwind setup is ready! The development server is running."
