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
module.exports = {
  content: [
    "./index.html",
    "./main.js",
    // Aggiungi eventuali altri file HTML o JavaScript che utilizzano classi Tailwind CSS
  ],
  theme: {
    extend: {},
    // Personalizza il tema se necessario
  },
  plugins: [],
  // Aggiungi eventuali plugin aggiuntivi se necessario
};
"@
$tailwindConfigJs | Out-File -FilePath "./tailwind.config.js" -Encoding utf8 -Force

# Aggiornamento di style.css
$styleCssContent = @"
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

@tailwind base;
@tailwind components;
@tailwind utilities;

.vite-logo:hover
{
  filter: drop-shadow(0 0 2em #646cffaa);
  transition: all 0.3s;
}

.tailwind-logo:hover {
  filter: drop-shadow(0 0 2em #1eb2f7aa);
  transition: all 0.3s;
}

#counter:hover
{
  filter: drop-shadow(0 0 1px #29b7f8aa);
  background-color: #1eb2f7aa;
  transition: all 0.4s;
}
"@
$styleCssContent | Out-File -FilePath "./style.css" -Encoding utf8 -Force

# Aggiornamento di main.js
$jsContent = @"
import './style.css'

const counterButton = document.getElementById('counter');
let count = 0;
counterButton.addEventListener('click', () => {
  count++;
  counterButton.textContent = ``count is `${count}``;
});
"@

# Scrivi il contenuto nel file main.js
$jsContent | Out-File -FilePath "./main.js" -Encoding UTF8

# Aggiornamento di index.html
$htmlContent = @"
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vite + Tailwind App</title>
</head>
<body class="bg-gray-900 flex justify-center items-center h-screen">
    <main class="flex flex-col justify-center items-center">
        <section class="logo-container w-full flex justify-center items-center gap-3 ml-5 mb-5">
            <a href="https://vitejs.dev/">
              <img src="/vite.svg" alt="Vite Logo" class="vite-logo w-28"/>
            </a>
            <div class="text-white w-12 h-12 flex justify-center items-center text-4xl">+</div>
            <a href="https://tailwindcss.com/">
              <img src="tailwind.svg" alt="Tailwind CSS Logo" class="tailwind-logo w-[10rem] h-auto hover:shadow-lg " />
            </a>
        </section>
        <section class="counter">
            <div class="hello my-5 ml-6">
                <h1 class="text-white text-4xl font-bold">Hello Vite!</h1>
            </div>
            <section class="card-button">
                <div class="button-container flex justify-center items-center text-white">
                    <button id="counter" type="button" class="rounded-md bg-gray-950 px-3 py-2 font-semibold ">
                    count is 0
                    </button>
                </div>
                <div class="flex justify-center items-center">
                    <h3 class="my-6 text-white text-[0.9rem] text-center mx-auto pointer-events-none">Click on the Vite logo to learn more</h3>
                </div>
            </section>
        </section>
    </main>
    <script type="module" src="/main.js"></script>
</body>
</html>
"@
$htmlContent | Out-File -FilePath "./index.html" -Encoding utf8 -Force

# Download and replace the SVG file
$url = "https://raw.githubusercontent.com/luca-de-bar/tailwind-vite-setup/main/tailwind.svg"
$svgPath = "./tailwind.svg"
Invoke-WebRequest -Uri $url -OutFile $svgPath
Remove-Item -Path "./javascript.svg" -ErrorAction SilentlyContinue
Move-Item -Path "./tailwind.svg" -Destination "./public/tailwind.svg"

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

# Esecuzione automatica di npm run dev
Write-Host "Setting up your development environment..."
Start-Sleep -Seconds 3  # Optional: Delay to allow background tasks to complete
npm run dev

# Messaggio finale all'utente
Write-Host "Your Vite and Tailwind setup is ready! The development server is running."
