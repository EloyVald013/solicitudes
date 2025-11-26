Feature: Protección de Páginas del Sistema
  Como sistema de control de acceso
  Quiero proteger las páginas que requieren autenticación
  Para garantizar que solo usuarios autorizados accedan a funcionalidades específicas

  Scenario: Acceso a página de solicitudes sin login redirige a login
    When un usuario no autenticado intenta acceder a "/solicitudes/"
    Then es redirigido a la página de login
    And ve el parámetro "next=/solicitudes/" en la URL

  Scenario: Acceso a página de métricas sin login redirige a login
    When un usuario no autenticado intenta acceder a "/solicitudes/metricas/"
    Then es redirigido a la página de login
    And ve el parámetro "next=/solicitudes/metricas/" en la URL

  Scenario: Acceso a página de formularios sin login redirige a login
    When un usuario no autenticado intenta acceder a "/solicitudes/formularios/"
    Then es redirigido a la página de login

  Scenario: Acceso a gestión de usuarios requiere rol de administrador
    Given que existe un usuario con username "alumno_test" y rol "alumno"
    And el usuario "alumno_test" está autenticado
    When el usuario intenta acceder a "/auth/usuarios/"
    Then el usuario es redirigido a la página de bienvenida
    And ve un mensaje indicando acceso no autorizado

  Scenario: Usuario administrador puede acceder a gestión de usuarios
    Given que existe un administrador con username "admin" y password "adminpass123"
    And el administrador "admin" está autenticado
    When el administrador visita "/auth/usuarios/"
    Then ve la página de gestión de usuarios correctamente
    And ve la lista de usuarios registrados

  Scenario: Usuario no admin no ve opción "Gestionar Usuarios" en el menú
    Given que existe un usuario con username "alumno_test" y rol "alumno"
    And el usuario "alumno_test" está autenticado
    When el usuario visita la página de bienvenida
    Then no ve el enlace "Gestionar Usuarios" en el menú de navegación

  Scenario: Usuario administrador ve opción "Gestionar Usuarios" en el menú
    Given que existe un administrador con username "admin"
    And el administrador "admin" está autenticado
    When el administrador visita cualquier página del sistema
    Then ve el enlace "Gestionar Usuarios" en el menú de navegación

  Scenario: Middleware redirige a cambiar contraseña si debe_cambiar_password es True
    Given que existe un usuario "nuevo_usuario" con debe_cambiar_password en True
    And el usuario "nuevo_usuario" está autenticado
    When el usuario intenta acceder a "/solicitudes/"
    Then es redirigido a "/auth/cambiar-password/"
    And no puede acceder a otras páginas hasta cambiar su contraseña

  Scenario: Middleware redirige a completar perfil si perfil_completo es False
    Given que existe un usuario "usuario_perfil_incompleto" con perfil_completo en False
    And el usuario ya cambió su contraseña
    And el usuario "usuario_perfil_incompleto" está autenticado
    When el usuario intenta acceder a "/solicitudes/"
    Then es redirigido a "/auth/perfil/"
    And no puede acceder a otras páginas hasta completar su perfil

  Scenario: Usuario con perfil completo puede acceder libremente al sistema
    Given que existe un usuario "usuario_completo" con perfil_completo en True
    And el usuario ya cambió su contraseña
    And el usuario "usuario_completo" está autenticado
    When el usuario visita "/solicitudes/"
    Then accede correctamente a la página de solicitudes
    And no es redirigido a ninguna página de configuración

  Scenario: URLs permitidas son accesibles incluso con perfil incompleto
    Given que existe un usuario con perfil_completo en False
    And el usuario está autenticado
    When el usuario accede a las siguientes URLs:
      | URL                      |
      | /auth/logout/            |
      | /auth/perfil/            |
      | /auth/cambiar-password/  |
      | /static/css/style.css    |
    Then puede acceder a todas ellas sin redirecciones

  Scenario: Página de login es accesible sin autenticación
    When un usuario no autenticado visita "/auth/login/"
    Then ve la página de login correctamente
    And no es redirigido

  Scenario: Página de registro es accesible sin autenticación
    When un usuario no autenticado visita "/auth/registro/"
    Then ve la página de registro correctamente
    And no es redirigido

  Scenario: Usuario autenticado visitando login es redirigido a bienvenida
    Given que existe un usuario con username "usuario_test"
    And el usuario "usuario_test" está autenticado
    When el usuario intenta acceder a "/auth/login/"
    Then es redirigido a la página de bienvenida

  Scenario: Después del login, usuario es redirigido a la página solicitada originalmente
    When un usuario no autenticado intenta acceder a "/solicitudes/metricas/"
    And es redirigido al login con next=/solicitudes/metricas/
    And el usuario ingresa credenciales válidas
    And hace clic en iniciar sesión
    Then el usuario es redirigido a "/solicitudes/metricas/"
    And no a la página de bienvenida por defecto
