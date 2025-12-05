$file = "c:\Promo\promo-navidad\index.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Define the old validation code
$oldCode = @'
            // Validate minimum amounts
            if (tipoCompra.value === 'agencia') {
                const montoAgencia = parseFloat(document.getElementById('montoAgencia').value);
                if (!montoAgencia || montoAgencia < 5000) {
                    alert('El monto de la apuesta debe ser mayor o igual a $5.000');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '🎉 Enviar mi Participación';
                    return;
                }
            } else {
                const montoComercio = parseFloat(document.getElementById('monto').value);
                if (!montoComercio || montoComercio < 30000) {
                    alert('El monto de la compra debe ser mayor o igual a $30.000');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '🎉 Enviar mi Participación';
                    return;
                }
            }
'@

# Define the new validation code
$newCode = @'
            // Validate agencia section
            if (tipoCompra.value === 'agencia') {
                // Validate OCR
                const ocr = document.getElementById('ocr').value;
                if (!ocr || ocr.length !== 16) {
                    alert('Por favor, ingresá el Número OCR completo (16 dígitos)');
                    return;
                }

                // Validate agency number
                const nroAgencia = document.getElementById('nroAgencia').value;
                if (!nroAgencia || nroAgencia.length !== 5) {
                    alert('Por favor, ingresá el Número de Agencia completo (5 dígitos)');
                    return;
                }

                // Validate amount
                const montoAgencia = parseFloat(document.getElementById('montoAgencia').value);
                if (!montoAgencia || montoAgencia < 5000) {
                    alert('El monto de la apuesta debe ser mayor o igual a $5.000');
                    return;
                }

                // Validate image upload
                const ticketAgencia = document.getElementById('ticketAgencia').files[0];
                if (!ticketAgencia) {
                    alert('Por favor, subí la foto del ticket de agencia');
                    return;
                }
            } else {
                // Validate comercio section
                // Validate CUIT
                const cuitLocal = document.getElementById('cuitLocal').value;
                if (!cuitLocal || cuitLocal.length !== 13) {
                    alert('Por favor, ingresá el CUIT del Comercio completo (formato: XX-XXXXXXXX-X)');
                    return;
                }

                // Validate ticket number
                const nroComprobante = document.getElementById('nroComprobante').value;
                if (!nroComprobante || nroComprobante.length !== 13) {
                    alert('Por favor, ingresá el Número de Ticket o Factura completo (formato: XXXX-XXXXXXXX)');
                    return;
                }

                // Validate amount
                const montoComercio = parseFloat(document.getElementById('monto').value);
                if (!montoComercio || montoComercio < 30000) {
                    alert('El monto de la compra debe ser mayor o igual a $30.000');
                    return;
                }

                // Validate image upload
                const ticketComercio = document.getElementById('ticketComercio').files[0];
                if (!ticketComercio) {
                    alert('Por favor, subí la foto del ticket o factura');
                    return;
                }
            }
'@

# Replace the code
if ($content -match [regex]::Escape($oldCode)) {
    $newContent = $content -replace [regex]::Escape($oldCode), $newCode
    Set-Content $file -Value $newContent -Encoding UTF8 -NoNewline
    Write-Host "✓ Validation updated successfully!"
} else {
    Write-Host "✗ Could not find the old code to replace"
}
