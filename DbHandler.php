<?php

/**
 * Clase encargada de manejar todas las operaciones con la base de datos
 */
class DbHandler {

    private $conn;

    function __construct() {
        require_once dirname(__FILE__) . '/DbConnect.php';
        // abriendo conexión
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    /* métodos para la tabla usuarios */

    /**
     * Creando nuevo usuario
     * @param String $email Email
     * @param String $password Contraseña
     * @param String $nombre Nombre del usuario
     * @param String $apellidos Apellidos del usuario
     * @param String $telefono Teléfono del usuario
     * @param String $dni DNI / NIE / Pasaporte del usuario
     */
    public function crearUsuario($email, $password, $nombre, $apellidos, $telefono, $dni) {
        $response = array();

        // Comprobar si el usuario existe
        if (!$this->usuarioExiste($dni, $email)) {

            // consulta para insertar
            $stmt = $this->conn->prepare("INSERT INTO usuarios (email, password, nombre, apellidos, telefono, dni) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssssss", $email, $password, $nombre, $apellidos, $telefono, $dni);

            $result = $stmt->execute();

            $stmt->close();

            // Comprobar resultado
            if ($result) {
                $new_user_id = $this->conn->insert_id;
                // Usuario creado correctamente
                    return 'OK+'.$new_user_id;
            } else {
                // Fallo al crear el usuario
                return USER_CREATE_FAILED;
            }
        } else {
            // El usuario ya existe
            return USER_ALREADY_EXIST;
        }

        return $response;
    }


}

?>
