# Mejoras Implementadas en el Formulario de Participación

## Resumen
Se implementaron tres mejoras principales en el formulario de participación del sorteo "El Centro está de Fiesta":

1. **Validación mejorada de fotos** con alerts descriptivos y efectos visuales
2. **Flexibilización de validación** del número de agencia (1-5 dígitos)
3. **Modal de ayuda** para el número de agencia

---

## 1. Validación Mejorada de Fotos

### Cambios Realizados

#### Alert Descriptivo
- Mensaje mejorado con emoji ⚠️ y texto explicativo
- Indica claramente que la foto es obligatoria para participar
- Aplica tanto para agencia como para comercio

#### Efectos Visuales
- **Scroll automático** al campo de foto cuando falta
- **Resaltado visual** con borde rojo (#ef4444) y fondo rosado (#fee2e2)
- **Animación de sacudida** (shake) para llamar la atención
- **Desaparición automática** del resaltado después de 3 segundos

#### Código CSS Agregado
```css
@keyframes shake {
    0%, 100% { transform: translateX(0); }
    10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
    20%, 40%, 60%, 80% { transform: translateX(10px); }
}
```

---

## 2. Validación Flexible del Número de Agencia

### Antes
- Requería exactamente 5 dígitos
- Pattern: `[0-9]{5}`
- Mensaje: "5 dígitos"

### Después
- Acepta entre 1 y 5 dígitos
- Pattern: `[0-9]{1,5}`
- Mensaje: "Entre 1 y 5 dígitos"

### Validación JavaScript
```javascript
if (!nroAgencia || nroAgencia.length < 1 || nroAgencia.length > 5) {
    alert('Por favor, ingresá el Número de Agencia (entre 1 y 5 dígitos)');
    return;
}
```

---

## 3. Modales de Ayuda para OCR y Número de Agencia

### Componentes Agregados

#### Íconos de Ayuda
- Ícono de interrogación (?) junto a los labels "Número OCR" y "Número de Agencia"
- Tamaño pequeño: `h-4 w-4` (16x16px)
- Color azul con efecto hover
- Tooltip: "¿Dónde encuentro este dato?"
- Clase `align-middle` para alineación vertical correcta

#### Modales Responsive

**Modal de OCR:**
- Título: "¿Dónde encuentro el Número OCR?"
- Muestra la imagen: `assets/OCCRAYUDA.png`
- Botón "✅ Entendido" para cerrar

**Modal de Número de Agencia:**
- Título: "¿Dónde encuentro el Número de Agencia?"
- Muestra la imagen: `assets/AGENCIAAYUDA.png`
- Botón "✅ Entendido" para cerrar

#### Diseño Responsive

**Tamaños de Modal:**
```html
<div class="modal-content max-w-md md:max-w-2xl">
```
- Mobile: `max-w-md` (448px)
- Desktop: `md:max-w-2xl` (672px)

**Tamaños de Texto:**
- Emoji: `text-4xl md:text-5xl` (36px → 48px)
- Título: `text-xl md:text-2xl` (20px → 24px)
- Descripción: `text-sm md:text-base` (14px → 16px)

**Espaciado:**
- Márgenes: `mb-4` en lugar de `mb-6` (más compacto)
- Padding de botones: `py-3 px-4 md:py-4 md:px-6` (responsive)

#### Funcionalidad JavaScript
```javascript
// Modal de OCR
ocrHelpIcon.addEventListener('click', function () {
    ocrHelpModal.classList.remove('modal-hidden');
});

closeOcrHelpBtn.addEventListener('click', function () {
    ocrHelpModal.classList.add('modal-hidden');
});

// Modal de Agencia (similar)
```

---

## Archivos Modificados

### [index.html](file:///c:/Promo/promo-navidad/index.html)

**Cambios en CSS:**
- Agregada animación `@keyframes shake`

**Cambios en HTML:**
- Nuevo modal `ocrHelpModal` con diseño responsive
- Modal `agenciaHelpModal` actualizado con diseño responsive
- Íconos de ayuda pequeños (h-4 w-4) en campos OCR y Número de Agencia
- Actualizado pattern y texto de ayuda del campo de agencia

**Cambios en JavaScript:**
- Event listeners para abrir/cerrar modal de ayuda de OCR
- Event listeners para abrir/cerrar modal de ayuda de agencia
- Validación mejorada de fotos con efectos visuales
- Validación flexible del número de agencia (1-5 dígitos)
- Removido atributo `required` de campos de foto (validación manual)

---

## Pruebas Realizadas

✅ **Validación de fotos:**
- Alert se muestra correctamente cuando falta la foto
- Scroll automático funciona
- Resaltado visual y animación se aplican
- Resaltado desaparece después de 3 segundos

✅ **Número de agencia:**
- Acepta 1 dígito (ej: "1")
- Acepta 5 dígitos (ej: "12345")
- Rechaza más de 5 dígitos
- Mensaje de error actualizado

✅ **Modales de ayuda:**
- Íconos pequeños y visibles
- Modales responsive (se adaptan a mobile y desktop)
- Imágenes se muestran correctamente
- Modales se cierran con el botón
- Funciona tanto para OCR como para Número de Agencia

---

## Notas Importantes

> [!IMPORTANT]
> Los usuarios deben refrescar la página con `Ctrl + F5` para ver los cambios, ya que el navegador puede tener la versión anterior en caché.

> [!TIP]
> Las imágenes `OCCRAYUDA.png` y `AGENCIAAYUDA.png` deben existir en la carpeta `assets/` para que los modales funcionen correctamente.

> [!NOTE]
> Los modales son completamente responsive:
> - En mobile (< 768px): ancho máximo de 448px
> - En desktop (≥ 768px): ancho máximo de 672px
> - Textos y espaciados se ajustan automáticamente
