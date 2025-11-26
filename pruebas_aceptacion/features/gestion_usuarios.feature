Feature: Gestión de Usuarios por Administrador
  Como administrador del sistema
  Quiero poder gestionar los usuarios registrados
  Para mantener control sobre quién tiene acceso al sistema

  Background:
    Given que existe un administrador con username "admin" y password "adminpass123"
    And el administrador "admin" está autenticado

  Scenario: Visualizar lista de usuarios
    Given que existen los siguientes usuarios en el sistema:
      | username  | email           | rol                    |
      | alumno1   | al1@test.com    | alumno                 |
      | control1  | con1@test.com   | control_escolar        |
      | director1 | dir1@test.com   | director               |
    When el administrador visita la página de gestión de usuarios
    Then ve una lista con 4 usuarios
    And ve el usuario "alumno1" en la lista
    And ve el usuario "control1" en la lista
    And ve el usuario "director1" en la lista

  Scenario: Editar información de un usuario
    Given que existe previamente un usuario con username "alumno_edit" y email "antes@test.com"
    When el administrador visita la página de edición del usuario "alumno_edit"
    And cambia el email a "despues@test.com"
    And cambia el first_name a "Editado"
    And guarda los cambios
    Then el usuario "alumno_edit" tiene email "despues@test.com"
    And el usuario "alumno_edit" tiene first_name "Editado"

  Scenario: Cambiar el rol de un usuario
    Given que existe un usuario registrado con username "cambio_rol" y rol "alumno"
    When el administrador visita la página de edición del usuario "cambio_rol"
    And cambia el rol a "control_escolar"
    And guarda los cambios
    Then el usuario "cambio_rol" tiene rol "control_escolar"

  Scenario: Desactivar usuario
    Given que existe previamente un usuario con username "usuario_activo" y está activo
    When el administrador visita la página de edición del usuario "usuario_activo"
    And marca el usuario como inactivo
    And guarda los cambios
    Then el usuario "usuario_activo" está inactivo

  Scenario: Eliminar un usuario
    Given que existe previamente un usuario con username "usuario_eliminar"
    When el administrador visita la página de gestión de usuarios
    And elimina el usuario "usuario_eliminar"
    Then no existe un usuario con username "usuario_eliminar" en la base de datos

  Scenario: Administrador no puede eliminarse a sí mismo
    When el administrador visita la página de gestión de usuarios
    Then no ve el botón de eliminar junto a su propio usuario

  Scenario: Usuario no administrador no puede acceder a gestión de usuarios
    Given que existe un usuario con username "alumno_no_admin" y password "pass123" y rol "alumno"
    And el usuario "alumno_no_admin" está autenticado
    When el usuario intenta acceder a la página de gestión de usuarios
    Then el usuario es redirigido a la página de bienvenida

  Scenario: Administrador no puede quitarse su propio rol de administrador
    When el administrador visita la página de edición de su propio usuario
    And intenta cambiar su rol a "alumno"
    And guarda los cambios
    Then ve un mensaje de error "No puedes quitarte tu propio rol de administrador"
    And su rol permanece como "administrador"

  Scenario: Administrador no puede desactivarse a sí mismo
    When el administrador visita la página de edición de su propio usuario
    And intenta marcar su cuenta como inactiva
    And guarda los cambios
    Then ve un mensaje de error "No puedes desactivar tu propia cuenta"
    And su cuenta permanece activa

  Scenario: No se puede cambiar el rol del último administrador activo
    Given que el administrador "admin" es el único administrador activo
    When el administrador visita la página de edición de su propio usuario
    And intenta cambiar su rol a "director"
    And guarda los cambios
    Then ve un mensaje de error "No puedes cambiar tu rol porque eres el último administrador activo"
    And su rol permanece como "administrador"

  Scenario: No se puede desactivar al último administrador activo
    Given que el administrador "admin" es el único administrador activo
    When el administrador visita la página de edición de su propio usuario
    And intenta marcar su cuenta como inactiva
    And guarda los cambios
    Then ve un mensaje de error "No puedes desactivarte porque eres el último administrador activo"
    And su cuenta permanece activa

  Scenario: No se puede eliminar al último administrador activo
    Given que el administrador "admin" es el único administrador activo
    When el administrador intenta eliminar su propia cuenta
    Then ve un mensaje de error indicando que no puede eliminarse siendo el último administrador
    And su cuenta sigue existiendo en el sistema

  Scenario: Se puede cambiar rol de admin si hay otros administradores activos
    Given que existe otro administrador con username "admin2" activo
    When el administrador "admin" visita la página de edición de su propio usuario
    And cambia su rol a "director"
    And guarda los cambios
    Then los cambios se guardan exitosamente
    And el usuario "admin" tiene rol "director"

  Scenario: Validación de email duplicado en edición de usuario
    Given que existe un usuario con username "usuario1" y email "usuario1@test.com"
    And que existe un usuario con username "usuario2" y email "usuario2@test.com"
    When el administrador visita la página de edición del usuario "usuario1"
    And intenta cambiar el email a "usuario2@test.com"
    And guarda los cambios
    Then ve un mensaje de error "Este correo electrónico ya está registrado"
    And el email de "usuario1" permanece como "usuario1@test.com"

  Scenario: Validación de username duplicado en edición de usuario
    Given que existe un usuario con username "usuario1"
    And que existe un usuario con username "usuario2"
    When el administrador visita la página de edición del usuario "usuario1"
    And intenta cambiar el username a "usuario2"
    And guarda los cambios
    Then ve un mensaje de error "Este nombre de usuario ya está en uso"
    And el username permanece como "usuario1"

  Scenario: Validación de matrícula duplicada en edición de usuario
    Given que existe un usuario con username "alumno1" y matricula "12345"
    And que existe un usuario con username "alumno2" y matricula "67890"
    When el administrador visita la página de edición del usuario "alumno1"
    And intenta cambiar la matricula a "67890"
    And guarda los cambios
    Then ve un mensaje de error "Esta matrícula ya está registrada"
    And la matricula de "alumno1" permanece como "12345"

  Scenario: Validación de nombre con números rechazada en edición
    Given que existe un usuario con username "usuario_test"
    When el administrador visita la página de edición del usuario "usuario_test"
    And intenta cambiar el first_name a "Juan123"
    And guarda los cambios
    Then ve un mensaje de error "El nombre solo puede contener letras y espacios"

  Scenario: Validación de teléfono con formato incorrecto en edición
    Given que existe un usuario con username "usuario_test"
    When el administrador visita la página de edición del usuario "usuario_test"
    And intenta cambiar el telefono a "492abc"
    And guarda los cambios
    Then ve un mensaje de error "El teléfono debe tener exactamente 10 dígitos"

  Scenario: Usuario puede mantener sus propios datos al editar
    Given que existe un usuario con username "usuario1" y email "propio@test.com"
    When el administrador visita la página de edición del usuario "usuario1"
    And mantiene el email como "propio@test.com"
    And cambia solo el first_name a "Nuevo Nombre"
    And guarda los cambios
    Then los cambios se guardan exitosamente sin error de duplicados

