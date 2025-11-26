# Pruebas de Aceptación - DSM5-5 (Login, Registro y Gestión de Usuarios)

Este directorio contiene las pruebas de aceptación escritas con **Behave (BDD)** para validar las funcionalidades implementadas en el módulo DSM5-5.

## 📋 Cobertura de Pruebas

### ✅ Features Actualizadas

#### 1. **login.feature** (Actualizada)
Pruebas de autenticación y manejo de sesiones:
- Login exitoso y fallido
- Acceso a páginas protegidas
- Logout
- **NUEVO:** Visualización de credenciales admin por defecto
- **NUEVO:** Redirección automática a cambio de contraseña
- **NUEVO:** Ocultamiento de credenciales después de cambio
- **NUEVO:** Redirección a completar perfil

**Escenarios:** 9 (5 nuevos)

#### 2. **registro.feature** (Actualizada)
Pruebas de registro de nuevos usuarios:
- Registro exitoso de alumno y administrador
- Validación de campos obligatorios
- **NUEVO:** Validación de formato de nombres (solo letras)
- **NUEVO:** Validación de username duplicado
- **NUEVO:** Validación de username con caracteres especiales
- **NUEVO:** Validación de email duplicado
- **NUEVO:** Validación de teléfono (10 dígitos exactos)
- **NUEVO:** Validación de matrícula (5-8 dígitos)
- **NUEVO:** Validación de matrícula duplicada
- **NUEVO:** Validación de contraseña débil/corta

**Escenarios:** 16 (11 nuevos)

#### 3. **gestion_usuarios.feature** (Actualizada)
Pruebas de gestión de usuarios por administradores:
- Visualizar, editar, eliminar usuarios
- Cambiar roles y estados
- **NUEVO:** Admin no puede quitarse su propio rol
- **NUEVO:** Admin no puede desactivarse a sí mismo
- **NUEVO:** Protección del último administrador activo
- **NUEVO:** Validación de email duplicado en edición
- **NUEVO:** Validación de username duplicado en edición
- **NUEVO:** Validación de matrícula duplicada en edición
- **NUEVO:** Validación de formatos en edición
- **NUEVO:** Usuario puede mantener sus propios datos

**Escenarios:** 17 (11 nuevos)

### 🆕 Features Nuevas

#### 4. **cambiar_password.feature** (Nueva)
Pruebas de cambio obligatorio de contraseña:
- Cambio obligatorio para admin nuevo
- Cambio exitoso de contraseña
- Validación de contraseña débil/corta/común
- Validación de contraseñas no coincidentes
- Validación de contraseña actual incorrecta
- Validación de contraseña similar al username
- Cambio voluntario de contraseña

**Escenarios:** 8

#### 5. **completar_perfil.feature** (Nueva)
Pruebas de middleware de perfil incompleto:
- Redirección automática a completar perfil
- Completar perfil exitosamente
- Validación de nombres (solo letras)
- Validación de email duplicado
- Validación de teléfono (formato, longitud)
- Validación de matrícula (rango, duplicados)
- Usuario puede mantener su propio email

**Escenarios:** 12

#### 6. **proteccion_paginas.feature** (Nueva)
Pruebas de protección de páginas y middleware:
- Redirección a login sin autenticación
- Protección de gestión de usuarios (solo admins)
- Visibilidad de enlaces según rol
- Middleware de cambio obligatorio de contraseña
- Middleware de perfil incompleto
- URLs permitidas sin restricciones
- Acceso público a login y registro
- Redirección después del login a página solicitada

**Escenarios:** 16

## 📊 Resumen Total

| Feature                  | Escenarios Totales | Nuevos | Actualizados |
|--------------------------|-------------------|--------|--------------|
| login.feature            | 9                 | 5      | 4            |
| registro.feature         | 16                | 11     | 5            |
| gestion_usuarios.feature | 17                | 11     | 6            |
| cambiar_password.feature | 8                 | 8      | 0            |
| completar_perfil.feature | 12                | 12     | 0            |
| proteccion_paginas.feature| 16               | 16     | 0            |
| **TOTAL**                | **78**            | **63** | **15**       |

## 🗂️ Estructura de Archivos

```
pruebas_aceptacion/
├── features/
│   ├── login.feature (actualizada)
│   ├── registro.feature (actualizada)
│   ├── gestion_usuarios.feature (actualizada)
│   ├── cambiar_password.feature (nueva)
│   ├── completar_perfil.feature (nueva)
│   ├── proteccion_paginas.feature (nueva)
│   └── steps/
│       ├── login_steps.py
│       ├── registro_steps.py
│       ├── gestion_usuarios_steps.py
│       ├── cambiar_password_steps.py (nuevo)
│       ├── completar_perfil_steps.py (nuevo)
│       └── proteccion_paginas_steps.py (nuevo)
└── README_DSM5-5.md (este archivo)
```

## 🚀 Cómo Ejecutar las Pruebas

### Ejecutar todas las pruebas:
```bash
behave pruebas_aceptacion/features/
```

### Ejecutar una feature específica:
```bash
behave pruebas_aceptacion/features/cambiar_password.feature
behave pruebas_aceptacion/features/completar_perfil.feature
behave pruebas_aceptacion/features/proteccion_paginas.feature
```

### Ejecutar con salida detallada:
```bash
behave -v pruebas_aceptacion/features/
```

### Ejecutar un escenario específico:
```bash
behave pruebas_aceptacion/features/cambiar_password.feature -n "Cambio exitoso de contraseña"
```

## 🔍 Validaciones Cubiertas

### Validaciones de Formato
- ✅ Nombres: Solo letras y espacios (con acentos y ñ)
- ✅ Username: Solo letras, números y guiones bajos
- ✅ Email: Formato válido
- ✅ Teléfono: Exactamente 10 dígitos
- ✅ Matrícula: 5-8 dígitos

### Validaciones de Unicidad
- ✅ Email único en el sistema
- ✅ Username único en el sistema
- ✅ Matrícula única en el sistema
- ✅ Excepción: Usuario puede mantener sus propios valores al editar

### Validaciones de Seguridad
- ✅ Contraseña mínimo 8 caracteres
- ✅ Contraseña no puede ser muy común
- ✅ Contraseña no puede ser muy similar al username
- ✅ Contraseñas deben coincidir
- ✅ Contraseña actual debe ser correcta

### Protecciones de Administrador
- ✅ Admin no puede quitarse su propio rol
- ✅ Admin no puede desactivarse a sí mismo
- ✅ No se puede cambiar rol del último admin activo
- ✅ No se puede desactivar al último admin activo
- ✅ No se puede eliminar al último admin activo

### Middleware y Redirecciones
- ✅ Cambio obligatorio de contraseña para nuevos usuarios
- ✅ Completar perfil obligatorio después de cambio de contraseña
- ✅ Redirección a login para páginas protegidas
- ✅ Solo administradores acceden a gestión de usuarios
- ✅ Redirección a página solicitada después del login

## 📝 Notas Importantes

1. **Orden de Ejecución:** Algunas pruebas dependen del estado de la base de datos. Se recomienda ejecutar con una base de datos limpia.

2. **Usuario Admin Predeterminado:** Las pruebas asumen que el sistema crea automáticamente un usuario admin con credenciales `admin/admin` en el primer inicio.

3. **Middleware:** Las pruebas de middleware requieren que `CompletarPerfilMiddleware` esté registrado en `settings.MIDDLEWARE`.

4. **Fixtures:** Los steps crean y limpian usuarios según sea necesario. No se requieren fixtures externas.

## 🐛 Troubleshooting

### Errores comunes:

1. **"Usuario no encontrado"**: Verifica que los steps de `given` estén creando los usuarios correctamente.

2. **"Redirección no esperada"**: Verifica que el middleware esté configurado correctamente en settings.py.

3. **"Validación no funciona"**: Asegúrate de que los formularios tengan los métodos `clean_*` implementados.

## 📚 Referencias

- [Behave Documentation](https://behave.readthedocs.io/)
- [Django Testing Tools](https://docs.djangoproject.com/en/5.0/topics/testing/)
- [BDD Best Practices](https://cucumber.io/docs/bdd/)

## ✅ Checklist de Implementación

- [x] Actualizar login.feature con escenarios de admin
- [x] Actualizar registro.feature con validaciones
- [x] Actualizar gestion_usuarios.feature con protecciones
- [x] Crear cambiar_password.feature
- [x] Crear completar_perfil.feature
- [x] Crear proteccion_paginas.feature
- [x] Implementar cambiar_password_steps.py
- [x] Implementar completar_perfil_steps.py
- [x] Implementar proteccion_paginas_steps.py
- [ ] Ejecutar todas las pruebas y verificar
- [ ] Generar reporte de cobertura
- [ ] Documentar en TESTING.md principal
