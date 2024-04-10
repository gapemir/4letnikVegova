<?php

$method = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];

$mysqli = new mysqli("193.2.190.23", "gasper2112", "nemga12516", "R4_Nemgar30", "3306");
$mysqli->set_charset('utf8');

$selectVse = "SELECT * FROM strezba";
$stmt  = $mysqli->prepare("SELECT * FROM strezba WHERE id = ?");
$stmtRacunSt  = $mysqli->prepare("SELECT * FROM prodaja_repl WHERE strac = ?");
$stmtRacunKelnar  = $mysqli->prepare("SELECT * FROM prodaja_repl JOIN strezba ON strezba.id=prodaja_repl.strezba WHERE strezba = ?");

switch ($method | $uri) {
        /*
   * endpoint: GET /api/v1/strezba
   * vrne vse 
   */
    case ($method == 'GET' && $uri == '/api/v1/strezba'):

        header('Content-Type: application/json');
        $res = $mysqli->execute_query($selectVse);
        $data = $res->fetch_all(MYSQLI_ASSOC);

        if (count($data) < 1) {   // pseudo, če zapisov ni
            http_response_code(404);
            echo json_encode(['404' => 'ni zapisov']);
            break;
        }

        echo json_encode($data, JSON_PRETTY_PRINT);
        break;
        /*
   * endpoint GET /api/v1/strezba/{id}
   * vrne enega
   */
    case ($method == 'GET' && preg_match('/\/api\/v1\/strezba\/[1-9]+/', $uri)):

        header('Content-Type: application/json');

        $id = basename($uri);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode($data, JSON_PRETTY_PRINT);

        break;


    case ($method == 'GET' && $uri == '/api/v1/racun'):
        http_response_code(404);
        echo json_encode(['404' => 'nespecificiran račun']);
        break;
    case ($method == 'GET' && preg_match('/\/api\/v1\/racun\/[1-9]+/', $uri)):
        header('Content-Type: application/json');
        $id = basename($uri);
        $stmtRacunSt->bind_param("i", $id);
        $stmtRacunSt->execute();
        $result = $stmtRacunSt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode($data, JSON_PRETTY_PRINT);
        break;
    case ($method == 'GET' && preg_match('/\/api\/v1\/racun\/[a-zA-Z]+/', $uri)):
        header('Content-Type: application/json');
        $id = basename($uri);
        $stmtRacunKelnar->bind_param("s", $id);
        $stmtRacunKelnar->execute();
        $result = $stmtRacunKelnar->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode($data, JSON_PRETTY_PRINT);
        break;
}
