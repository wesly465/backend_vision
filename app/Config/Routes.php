<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
// En app/Config/Routes.php
$routes->group('api', function ($routes) {
    $routes->post('scanimg/detect', 'Vision::detect');
});





