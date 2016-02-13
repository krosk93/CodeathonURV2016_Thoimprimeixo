<?php

/**
 * Clase para conectar a la base de datos
 */
class DbConnect {

    private $conn;

    function __construct() {
    }

    /**
     * Establece conexión
     * @return handler de la conexión
     */
    function connect() {
        include_once dirname(__FILE__) . '/Config.php';

        $this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }
        $this->conn->set_charset("utf8");

        return $this->conn;
    }

}

?>
