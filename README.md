# G5 Automation Tests
Selenium Webdriver Automation test solution for G5.

## Current Version

0.3.1

## Requirements

* [selenium-webdriver](https://github.com/SeleniumHQ/selenium) >= 3.142.3

## List of Tests Available

### Release Candidate

* Regression Testing of Basic Functionalities (Regression.rb)
* Smoke Testing of Basic Functionalities (Smoke.rb)

### Widgets

* Floor plans plus full test (FPP.rb) - WIP

## Run Tests

1. First you will need to be inside the folder that you want to test, in this example we will be inside the `Tests/RC/` folder.

2. To run any of the tests inside the `Tests/RC/` folder you will need to run the following example code in your terminal:

   ```console
   ruby Smoke.rb
   ```

3. After you will be prompted inside the terminal to provide your G5 credentials to login:

   ```console
   Type your G5 email:
   email
   Type your G5 password:
   password
   ```

4. And then the automation of that test will begin.

## Configuration

### Changing environment variables

(IN PROGRESS)

### Creating new test cases

(IN PROGRESS)

### Understanding POM

(IN PROGRESS)

## Authors

* Bryan Argandoña / [@iBryan6](https://github.com/iBryan6)

## Contributing

1. [Fork it](https://github.com/G5/g5_authenticatable/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write your code and **specs**
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## License

Copyright (c) 2014 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
