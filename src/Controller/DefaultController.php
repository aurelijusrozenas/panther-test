<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController
{
    /**
     * @Route(path="/")
     */
    public function action(): Response
    {
        return new Response('<html><body>Test</body></html>');
    }
}
