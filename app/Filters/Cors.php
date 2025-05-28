<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;

class Cors implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        $origin = $_SERVER['HTTP_ORIGIN'] ?? '*';
        $allowedOrigin = getenv('CORS_ALLOWED_ORIGIN') ?: '*';

        // Permitir si el origen es el correcto o se permite cualquier origen
        if ($allowedOrigin === '*' || $origin === $allowedOrigin) {
            header('Access-Control-Allow-Origin: ' . $origin);
            header('Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE');
            header('Access-Control-Allow-Headers: Content-Type, Authorization');
            header('Access-Control-Allow-Credentials: true');
        }

        // Manejar solicitudes preflight OPTIONS
        if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
            http_response_code(200);
            exit;
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        $origin = $_SERVER['HTTP_ORIGIN'] ?? '*';
        $allowedOrigin = getenv('CORS_ALLOWED_ORIGIN') ?: '*';

        if ($allowedOrigin === '*' || $origin === $allowedOrigin) {
            $response->setHeader('Access-Control-Allow-Origin', $origin);
            $response->setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
            $response->setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
            $response->setHeader('Access-Control-Allow-Credentials', 'true');
        }

        return $response;
    }
}

