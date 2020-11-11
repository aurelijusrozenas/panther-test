<?php

declare(strict_types=1);

namespace App\Tests;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Panther\PantherTestCaseTrait;

class DefaultTest extends WebTestCase
{
    use PantherTestCaseTrait;

    public function test(): void
    {
        $client = self::createPantherClient();
        $client->request(Request::METHOD_GET, '/');
        $this->addToAssertionCount(1);
    }
}
