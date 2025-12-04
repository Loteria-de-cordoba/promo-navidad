# Script para agregar iconos de ayuda y modal de imágenes
$htmlPath = "c:\Promo\promo-navidad\index.html"
$content = Get-Content -Path $htmlPath -Raw -Encoding UTF8

# 1. Agregar icono de ayuda en el label de OCR
$content = $content -replace '(<label for="ocr" class="block text-sm font-semibold text-gray-700 mb-2">[\r\n\s]+Número OCR \*[\r\n\s]+</label>)', @'
<label for="ocr" class="block text-sm font-semibold text-gray-700 mb-2">
                                Número OCR * 
                                <button type="button" onclick="showHelpModal('assets/ocrayuda.png', 'Ubicación del Número OCR')" class="ml-2 inline-flex items-center justify-center w-5 h-5 text-xs font-bold text-white bg-blue-500 rounded-full hover:bg-blue-600 transition-colors" title="Ver ayuda">?</button>
                            </label>
'@

# 2. Agregar icono de ayuda en el label de Número de Agencia
$content = $content -replace '(<label for="nroAgencia" class="block text-sm font-semibold text-gray-700 mb-2">[\r\n\s]+Número de Agencia \*[\r\n\s]+</label>)', @'
<label for="nroAgencia" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Número de Agencia * 
                                    <button type="button" onclick="showHelpModal('assets/agenciaayuda.png', 'Ubicación del Número de Agencia')" class="ml-2 inline-flex items-center justify-center w-5 h-5 text-xs font-bold text-white bg-blue-500 rounded-full hover:bg-blue-600 transition-colors" title="Ver ayuda">?</button>
                                </label>
'@

# 3. Agregar el modal de ayuda antes del cierre de </body>
$ModalHTML = @'

    <!-- Modal de Ayuda -->
    <div id="helpModal" class="modal-overlay modal-hidden" onclick="closeHelpModal()">
        <div class="modal-content" style="max-width: 800px;" onclick="event.stopPropagation()">
            <div class="text-center mb-4">
                <h2 id="helpModalTitle" class="text-2xl font-bold text-blue-900 mb-4">Ayuda</h2>
                <img id="helpModalImage" src="" alt="Imagen de ayuda" class="w-full rounded-lg shadow-lg">
            </div>
            <button onclick="closeHelpModal()" class="btn-accept w-full text-white font-bold py-3 px-6 rounded-lg text-lg mt-4">
                Cerrar
            </button>
        </div>
    </div>

    <script>
        // Funciones para el modal de ayuda
        function showHelpModal(imagePath, title) {
            const modal = document.getElementById('helpModal');
            const image = document.getElementById('helpModalImage');
            const titleElement = document.getElementById('helpModalTitle');
            
            image.src = imagePath;
            titleElement.textContent = title;
            modal.classList.remove('modal-hidden');
        }

        function closeHelpModal() {
            const modal = document.getElementById('helpModal');
            modal.classList.add('modal-hidden');
        }
    </script>
</body>
'@

$content = $content -replace '</body>', $modalHTML

# Guardar los cambios
Set-Content -Path $htmlPath -Value $content -Encoding UTF8 -NoNewline

Write-Host "Iconos de ayuda y modal agregados exitosamente"
