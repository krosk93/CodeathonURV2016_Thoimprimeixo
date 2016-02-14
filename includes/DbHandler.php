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
    public function crearUsuario($email, $password, $nombre, $apellidos, $telefono, $dni, $suscrito) {

        // Comprobar si el usuario existe
        if (!$this->usuarioExiste($dni, $email, $telefono)) {

            // consulta para insertar
            $stmt = $this->conn->prepare("INSERT INTO Usuarios (email, password, nombre, apellidos, telefono, dni, suscrito) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssssssi", $email, $password, $nombre, $apellidos, $telefono, $dni, $suscrito);

            $result = $stmt->execute();

            $stmt->close();

            // Comprobar resultado
            if ($result) {
                $new_user_id = $this->conn->insert_id;
                // Usuario creado correctamente
                    return 'OK+'.$new_user_id;
            } else {
                // Fallo al crear el usuario
                return OBJECT_CREATE_FAILED;
            }
        } else {
            // El usuario ya existe
            return OBJECT_ALREADY_EXISTS;
        }
    }

    /**
     * Buscar usuarios
     * @param Int id del usuario
     */
    public function buscarUsuario($q) {
        $stmt = $this->conn->prepare('SELECT * FROM Usuarios WHERE id=? LIMIT 20');
        $stmt->bind_param("i", $q);
        $stmt->execute();
        $usuarios = $stmt->get_result();
        $stmt->close();
        return $usuarios;
    }

    /**
     * Actualizar usuario
     * @param String $id id del usuario
     * @param String $campo campo a modificar
     * @param String $valor valor actualizado
     */
    public function actualizarUsuario($id, $campo, $valor) {
        $campo = $this->conn->escape_string($campo);
        $stmt = $this->conn->prepare("UPDATE Usuarios SET ".$campo."=? WHERE id=?");
        $stmt->bind_param("si", $valor, $id);
        $stmt->execute();
        $num_affected_rows = $stmt->affected_rows;
        $stmt->close();
        return $num_affected_rows > 0;
    }

    /**
     * Buscando si el usuario existe por DNI, por Email y por telefono
     * @param String $dni DNI del usuario
     * @param String $email Email del usuario
     * @param String $telefono Teléfono del usuario
     * @return boolean
     */
    private function usuarioExiste($dni, $email, $telefono) {
        $stmt = $this->conn->prepare("SELECT id FROM Usuarios WHERE dni=? OR email=? OR telefono=? LIMIT 1");
        $stmt->bind_param("sss", $dni, $email, $telefono);
        $stmt->execute();
        $stmt->store_result();
        $num_rows = $stmt->num_rows;
        $stmt->close();
        return $num_rows > 0;
    }

    /**
     * Obtener usuario por id
     * @param Integer $id id del usuario
     */
    public function obtenerUsuario($id) {
        $stmt = $this->conn->prepare("SELECT id, email, nombre, apellidos, telefono, dni, validado FROM Usuarios WHERE id = ?");
        $stmt->bind_param("i", $id);
        if ($stmt->execute()) {
            $result = $stmt->get_result()->fetch_array(MYSQLI_ASSOC);
            $stmt->close();
            return $result;
        } else {
            return NULL;
        }
    }

    /**
     * Buscar usuarios no validados
     * @return array Usuarios sin validar.
     */
    public function obtenerUsuariosNoValidados() {
        return $this->conn->query('SELECT id, email, dni FROM Usuarios WHERE validado = 0 ORDER BY dni DESC');
    }

    /**
     * Obtener emails de todos los usuarios
     * @return array Emails de todos los usuarios que aceptan recibir correos.
     */
    public function obtenerListaEmails() {
        $respuesta = array();
        if($resultado = $this->conn->query("SELECT email FROM Usuarios WHERE suscrito=1", MYSQLI_USE_RESULT)){
            while ($fila = $resultado->fetch_row()) {
                if (filter_var($fila[0], FILTER_VALIDATE_EMAIL)) $respuesta[] = $fila[0];
            }
            $resultado->close();
        }
        return $respuesta;
    }
}


/* métodos para la tabla Copisterias */

/**
 * Creando nueva copisteria
 * @param String $email Email
 * @param String $password Contraseña
 * @param String $nombre Nombre del usuario
 * @param String $latitud Latitud (Coordenadas)
 * @param String $longitud Longitud (Coordenadas)
 * @param String $direccion Direccion de la copisteria
 */
 public function crearCopisteria($email, $password, $nombre, $latitud, $longitud, $direccion) {

     // Comprobar si el usuario existe
     if (!$this->copisteriaExiste($email)) {

         // consulta para insertar
         $stmt = $this->conn->prepare("INSERT INTO Copisterias (email, password, nombre, latitud, longitud, direccion) VALUES (?, ?, ?, ?, ?, ?)");
         $stmt->bind_param("sssffs", $email, $password, $nombre, $apellidos, $telefono, $dni);

         $result = $stmt->execute();

         $stmt->close();

         // Comprobar resultado
         if ($result) {
             $new_copy_id = $this->conn->insert_id;
             // Usuario creado correctamente
                 return 'OK+'.$new_copy_id;
         } else {
             // Fallo al crear la copisteria
             return OBJECT_CREATE_FAILED;
         }
     } else {
         // La copisteria ya existe
         return OBJECT_ALREADY_EXISTS;
     }
 }

 /**
  * Buscando si el usuario existe por DNI, por Email y por telefono
  * @param String $dni DNI del usuario
  * @param String $email Email del usuario
  * @param String $telefono Teléfono del usuario
  * @return boolean
  */
 private function copisteriaExiste($email) {
     $stmt = $this->conn->prepare("SELECT id FROM Copisterias WHERE email=? LIMIT 1");
     $stmt->bind_param("s", $email);
     $stmt->execute();
     $stmt->store_result();
     $num_rows = $stmt->num_rows;
     $stmt->close();
     return $num_rows > 0;
 }



}

?>
