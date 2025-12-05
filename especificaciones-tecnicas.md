# Especificaciones Técnicas del Formulario
## Formulario de Participación - "El Centro Está de Fiesta"

---

## 1. Stack Tecnológico

### Frontend
- **HTML5**: Estructura semántica del formulario
- **TailwindCSS**: Framework CSS via CDN (`https://cdn.tailwindcss.com`)
- **JavaScript Vanilla**: Lógica de validación y envío
- **CSS Custom**: Animaciones y estilos personalizados

### Características Visuales
- **Diseño Responsive**: Mobile-first con breakpoints md (768px)
- **Efectos Visuales**:
  - Glass morphism (backdrop-filter: blur)
  - Gradientes lineares
  - Animaciones CSS (fadeIn, spin, shake, modalSlideIn)
  - Transiciones suaves (0.3s ease)

---

## 2. Estructura de Archivos

```
promo-navidad/
├── index.html          # Archivo principal
└── assets/
    ├── bancor.png                              # Imagen de premios
    ├── LDC Logotipo COLOR Vertical 300dpi.png  # Logo principal
    ├── LDC Logotipo BLANCO+COLOR Vertical 300dpi.png
    ├── OCCRAYUDA.png                           # Imagen ayuda OCR
    └── AGENCIAAYUDA.png                        # Imagen ayuda Agencia
```

---

## 3. Componentes UI

### 3.1 Modales

#### Modal de Premios
- **ID**: `prizesModal`
- **Clase**: `modal-overlay` (sin `modal-hidden` para mostrarse al inicio)
- **Contenido**:
  - Imagen de premios
  - Título y descripción
  - Instrucciones de participación
  - Botón "¡Quiero Participar!" (`continuePrizesBtn`)
  - Logo de Lotería de Córdoba

#### Modal de Términos y Condiciones
- **ID**: `termsModal`
- **Clase**: `modal-overlay modal-hidden`
- **Contenido**:
  - Lista ordenada con 21 puntos (punto 2 en **negritas**)
  - 2 checkboxes obligatorios:
    - Mayor de 18 años (`mayorEdadCheck`)
    - Aceptación de términos (`terminosCheck`)
  - Botón "Aceptar y Continuar" (`acceptTermsBtn`)

#### Modal de Ayuda OCR
- **ID**: `ocrHelpModal`
- **Clase**: `modal-overlay modal-hidden`
- **Contenido Responsive**:
  - Emoji: `text-4xl md:text-5xl`
  - Título: `text-xl md:text-2xl`
  - Imagen: `assets/OCCRAYUDA.png`
  - Botón cerrar: `closeOcrHelpBtn`

#### Modal de Ayuda Agencia
- **ID**: `agenciaHelpModal`
- **Clase**: `modal-overlay modal-hidden`
- **Contenido**: Similar a modal OCR
- **Imagen**: `assets/AGENCIAAYUDA.png`
- **Botón cerrar**: `closeAgenciaHelpBtn`

### 3.2 Loading Overlay
- **ID**: `loadingOverlay`
- **Clase**: `loading-overlay hidden`
- **z-index**: 10000
- **Contenido**:
  - Spinner animado (60x60px)
  - Texto: "Enviando tu participación..."
  - Subtexto: "Por favor, esperá un momento"

---

## 4. Campos del Formulario

### 4.1 Selección de Tipo de Compra
- **Tipo**: Radio buttons
- **Opciones**:
  - `agencia`: Compra en Agencia
  - `comercio`: Compra en Comercio
- **Comportamiento**: Muestra/oculta secciones correspondientes

### 4.2 Sección Agencia (`seccionAgencia`)

| Campo | ID | Tipo | Validación | Formato |
|-------|-----|------|------------|---------|
| Número OCR | `ocr` | text | 16 dígitos | `[0-9]{16}` |
| Número de Sucursal | `nroSucursal` | text | Readonly | "01 - CASA CENTRAL" |
| Número de Agencia | `nroAgencia` | text | 1-5 dígitos | `[0-9]{1,5}` |
| Monto de Apuesta | `montoAgencia` | number | ≥ $5,000 | min="5000" |
| Foto del Ticket | `ticketAgencia` | file | Obligatorio | image/* |

**Íconos de Ayuda**:
- OCR: `ocrHelpIcon` (h-4 w-4)
- Agencia: `agenciaHelpIcon` (h-4 w-4)

### 4.3 Sección Comercio (`seccionComercio`)

| Campo | ID | Tipo | Validación | Formato |
|-------|-----|------|------------|---------|
| CUIT del Comercio | `cuitLocal` | text | 13 caracteres | `XX-XXXXXXXX-X` |
| Nº Ticket/Factura | `nroComprobante` | text | 13 caracteres | `XXXX-XXXXXXXX` |
| Monto Total | `monto` | number | ≥ $25,000 | min="25000" |
| Medio de Pago | `medioPago` | radio | Opcional | bancor/otros |
| Foto Ticket/Factura | `ticketComercio` | file | Obligatorio | image/* |

**Auto-formato**:
- CUIT: Agrega guiones automáticamente
- Nº Comprobante: Agrega guión automáticamente

### 4.4 Datos Personales

| Campo | ID | Tipo | Validación | Formato |
|-------|-----|------|------------|---------|
| Nombre | `nombre` | text | Required | - |
| Apellido | `apellido` | text | Required | - |
| DNI | `dni` | text | 7-8 dígitos | `[0-9]{7,8}` |
| Género | `sexo` | radio | Required | M/F |
| Fecha Nacimiento | `fechaNacimiento` | date | ≤ 09/12/2007 | max="2007-12-09" |
| Código de Área | `codigoArea` | text | 2-4 dígitos | `[0-9]{2,4}` |
| Teléfono | `telefono` | text | 6-8 dígitos | `[0-9]{6,8}` |
| Email | `email` | email | Required | - |

---

## 5. Estilos CSS Personalizados

### 5.1 Clases Principales

```css
.glass-effect {
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(10px);
    box-shadow: 0 8px 32px 0 rgba(30, 58, 138, 0.3);
}

.input-field {
    transition: all 0.3s ease;
}

.input-field:focus {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
}

.btn-submit {
    background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%);
}

.btn-accept {
    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
}

.radio-card {
    cursor: pointer;
    transition: all 0.3s ease;
    border: 3px solid #e5e7eb;
}

.radio-card.selected {
    border-color: #3b82f6;
    background: rgba(59, 130, 246, 0.1);
}
```

### 5.2 Animaciones

```css
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
    20%, 40%, 60%, 80% { transform: translateX(10px); }
}

@keyframes modalSlideIn {
    from { opacity: 0; transform: translateY(-50px); }
    to { opacity: 1; transform: translateY(0); }
}
```

### 5.3 Loading Overlay

```css
.loading-overlay {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0, 0, 0, 0.8);
    z-index: 10000;
    backdrop-filter: blur(5px);
}

.loading-spinner {
    width: 60px; height: 60px;
    border: 5px solid #e5e7eb;
    border-top: 5px solid #3b82f6;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}
```

---

## 6. Paleta de Colores

| Elemento | Color | Código |
|----------|-------|--------|
| Fondo principal | Gradiente azul | `#1e3a8a` → `#3b82f6` |
| Texto principal | Gris oscuro | `#374151` |
| Bordes | Gris claro | `#e5e7eb` |
| Acento primario | Azul | `#3b82f6` |
| Botón submit | Rojo gradiente | `#dc2626` → `#ef4444` |
| Botón accept | Verde gradiente | `#10b981` → `#059669` |
| Error | Rojo | `#ef4444` |
| Error fondo | Rosa claro | `#fee2e2` |

---

## 7. Breakpoints Responsive

```css
/* Mobile First */
- Base: < 768px
- md: ≥ 768px (tablet/desktop)

/* Ejemplos */
text-xl md:text-2xl     /* 20px → 24px */
max-w-md md:max-w-2xl   /* 448px → 672px */
py-3 px-4 md:py-4 md:px-6
```

---

## 8. Dependencias Externas

### CDN
```html
<script src="https://cdn.tailwindcss.com"></script>
```

### Imágenes Requeridas
- `bancor.png`: Imagen de premios
- `LDC Logotipo COLOR Vertical 300dpi.png`
- `LDC Logotipo BLANCO+COLOR Vertical 300dpi.png`
- `OCCRAYUDA.png`: Guía visual para campo OCR
- `AGENCIAAYUDA.png`: Guía visual para campo Agencia

---

## 9. Compatibilidad

### Navegadores Soportados
- Chrome/Edge: 90+
- Firefox: 88+
- Safari: 14+

### Características Requeridas
- CSS Grid
- Flexbox
- backdrop-filter
- FileReader API
- Fetch API
- ES6+ (async/await, arrow functions, template literals)

---

## 10. Formato de Datos de Salida

### Estructura JSON
```json
{
  "tipo": "agencia" | "comercio",
  "persona": {
    "apellido": "string",
    "codigo_area": "string",
    "correo_electronico": "string",
    "dni": "string",
    "fecha_nacimiento": "YYYY-MM-DD",
    "nombre": "string",
    "genero": "M" | "F",
    "telefono": "string"
  },
  "agencia": {  // Solo si tipo === "agencia"
    "foto_ticket": "base64_string",
    "foto_tipo": "image/jpeg",
    "id_persona": "",
    "monto_apuesta": "string",
    "nro_agencia": "string",
    "nro_sucursal": "string",
    "ocr": "string"
  },
  "compra_comercio": {  // Solo si tipo === "comercio"
    "cuit_comercio": "string",
    "foto_ticket_factura": "base64_string",
    "foto_ticket_factura_tipo": "image/jpeg",
    "id_persona": "",
    "medio_pago": "bancor" | "otros" | "",
    "monto_total_compra": "string",
    "nro_ticket_factura": "string"
  }
}
```

### Conversión de Imágenes
- Método: `FileReader.readAsDataURL()`
- Formato: Base64 sin prefijo `data:image/xxx;base64,`
- Tipos aceptados: JPG, PNG, WebP
