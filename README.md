# Panther bug starting from 0.7.0 with Symfony 4.4 
Starting with v0.7.0 and above browser tests fail with `Uncaught Error: Undefined class constant 'self::CHROME'` when using `PantherTestCaseTrait` (example in `tests/DefaultTest.php`).

## Steps to reproduce
### 0.7.0
- git clone https://github.com/aurelijusrozenas/panther-test.git
- cd panther-test
- docker-compose build
- docker-compose up
- open another terminal
- docker-compose exec php composer install && docker-compose exec php vendor/bin/phpunit

This will fail with:
```
Fatal error: Uncaught Error: Undefined class constant 'self::CHROME' in /var/www/html/vendor/phpunit/phpunit/src/Framework/TestBuilder.php:138
Stack trace:
#0 /var/www/html/vendor/phpunit/phpunit/src/Framework/TestBuilder.php(117): PHPUnit\Framework\TestBuilder->buildTestWithoutData('App\\Tests\\Defau...')
#1 /var/www/html/vendor/phpunit/phpunit/src/Framework/TestSuite.php(875): PHPUnit\Framework\TestBuilder->build(Object(ReflectionClass), 'test')
#2 /var/www/html/vendor/phpunit/phpunit/src/Framework/TestSuite.php(235): PHPUnit\Framework\TestSuite->addTestMethod(Object(ReflectionClass), Object(ReflectionMethod))
#3 /var/www/html/vendor/phpunit/phpunit/src/Framework/TestSuite.php(365): PHPUnit\Framework\TestSuite->__construct(Object(ReflectionClass))
#4 /var/www/html/vendor/phpunit/phpunit/src/Framework/TestSuite.php(504): PHPUnit\Framework\TestSuite->addTestSuite(Object(ReflectionClass))
#5 /var/www/html/vendor/phpunit/phpunit/src/Framework/TestSuite.php(529): PHPUnit\Framework\TestSuite->addTestFile('/var/www/html/t...') in /var/www/html/vendor/phpunit/phpunit/src/TextUI/Command.php on line 103
```
### 0.8.0
- git checkout latest
- docker-compose exec php composer install && docker-compose exec php vendor/bin/phpunit

This will fail with:
```
Error: Undefined class constant 'CHROME'

/var/www/html/vendor/symfony/panther/src/PantherTestCaseTrait.php:179
/var/www/html/tests/DefaultTest.php:17
```
### 0.6.1 Last working version
- git checkout last-working
- docker-compose exec php composer install && docker-compose exec php vendor/bin/phpunit

This will pass, hooray!
