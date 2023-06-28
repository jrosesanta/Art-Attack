<?php

// Defining namespace for application
namespace ArtAttack;

// Load Autoload
require_once ('vendor/autoload.php');

// Define constants
define('APP_ROOT', __DIR__);
define('VIEW_PATH', APP_ROOT . '/views');

// Load config
$config = include APP_ROOT . '/config.php';

// Setup Database
$db = new \PDO(
    $config['db']['dsn'],
    $config['db']['username'],
    $config['db']['password']
);

// Create and configure Slim app
$app = new \Slim\App($config['slim']);

// Register Routes
$app->get('/', '\\ArtAttack\\Controllers\\HomeController:index');

// Run application
$app->run();

// Controllers
class HomeController {
    public function index($request, $response) {
        // Render view
        return $this->render($response, 'index.php');
    }
    
    protected function render($response, $template, array $params = []) {
        // Set response content type
        $response->withHeader('Content-Type', 'text/html');
        // Render view
        $response->getBody()->write(
            call_user_func(function () use ($template, $params) {
                ob_start();
                extract($params);
                include VIEW_PATH . '/' . $template;
                return ob_get_clean();
            })
        );
        // Return response
        return $response;
    }
}

// Models
class Artist {
    protected $db;

    public function __construct(\PDO $db) {
        $this->db = $db;
    }

    public function findByName($name) {
        $stmt = $this->db->prepare('SELECT * FROM `artists` WHERE `name` = :name');
        $stmt->execute([':name' => $name]);
        return $stmt->fetch();
    }

    public function findByGenre($genre) {
        $stmt = $this->db->prepare('SELECT * FROM `artists` WHERE `genre` = :genre');
        $stmt->execute([':genre' => $genre]);
        return $stmt->fetchAll();
    }
}

class Artwork {
    protected $db;

    public function __construct(\PDO $db) {
        $this->db = $db;
    }

    public function findByArtist($artistId) {
        $stmt = $this->db->prepare('SELECT * FROM `artworks` WHERE `artistId` = :id');
        $stmt->execute([':id' => $artistId]);
        return $stmt->fetchAll();
    }

    public function findByGenre($genre) {
        $stmt = $this->db->prepare('SELECT * FROM `artworks` WHERE `genre` = :genre');
        $stmt->execute([':genre' => $genre]);
        return $stmt->fetchAll();
    }
}

class Gallery {
    protected $db;

    public function __construct(\PDO $db) {
        $this->db = $db;
    }

    public function findByLocation($location) {
        $stmt = $this->db->prepare('SELECT * FROM `galleries` WHERE `location` = :location');
        $stmt->execute([':location' => $location]);
        return $stmt->fetchAll();
    }

    public function findByArtwork($artworkId) {
        $stmt = $this->db->prepare('SELECT * FROM `galleries` WHERE `artworkId` = :id');
        $stmt->execute([':id' => $artworkId]);
        return $stmt->fetchAll();
    }
}

// Views
// index.php
<html>
    <head>
        <title>Art Attack</title>
    </head>
    <body>
        <h1>Welcome to Art Attack!</h1>
    </body>
</html>