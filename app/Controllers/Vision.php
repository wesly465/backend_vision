<?php

namespace App\Controllers;
use CodeIgniter\RESTful\ResourceController;

class Vision extends ResourceController
{
    public function detect()
    {
        $data = $this->request->getJSON();

        if (!$data || !isset($data->image)) {
            return $this->failValidationErrors('Imagen no proporcionada');
        }

        $apiKey = getenv('GOOGLE_VISION_API_KEY');
        if (!$apiKey) {
            return $this->failServerError('API key no configurada en el backend.');
        }

        $visionUrl = "https://vision.googleapis.com/v1/images:annotate?key={$apiKey}";

        $payload = json_encode([
            "requests" => [
                [
                    "image" => [ "content" => $data->image ],
                    "features" => [
                        ["type" => "DOCUMENT_TEXT_DETECTION"]
                    ]
                ]
            ]
        ]);

        $client = \Config\Services::curlrequest();

        try {
            $response = $client->post($visionUrl, [
                'headers' => ['Content-Type' => 'application/json'],
                'body' => $payload
            ]);

            return $this->respond(json_decode($response->getBody(), true));
        } catch (\Exception $e) {
            return $this->failServerError("Error en la petición a Google Vision: " . $e->getMessage());
        }
    }
}
