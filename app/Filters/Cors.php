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

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        header('Access-Control-Allow-Origin: ' . $origin);
        header('Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE');
        header('Access-Control-Allow-Headers: Content-Type, Authorization');
        header('Access-Control-Allow-Credentials: true');
        http_response_code(200);
        exit;
    }
}


 public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
{
    $origin = $_SERVER['HTTP_ORIGIN'] ?? '*';

    return $response
        ->setHeader('Access-Control-Allow-Origin', $origin)
        ->setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE')
        ->setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        ->setHeader('Access-Control-Allow-Credentials', 'true');
}

}
