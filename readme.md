# Log Parser

## To run this project execute the following command
`./parser.rb webserver.log`

*(Note: you might need to make it executable by `chmod +x parser.rb`)*


### To run test cases exeute following commands
`ruby test/log_analyzer_test.rb`
`ruby test/log_analytics_test.rb`


## Work Flow
1. First we execute the `./parser.rb webserver.log`
  - if the webserver.log file is not present, it will raise the error of File not found, and if we don't pass the file from command it will return a message.
2. Now let's say we have a file present with valid logs.
3. It will create a hash with path, IP address, and its occurrence per path.
4. Here is the example hash that will be created in the analyzer class.
  ```ruby
    {
      :'/index' => {
        :'123.123.123.123' => 2,
        :'234.234.234.234' => 4
      },
      :'/home' => {
        :'123.123.123.123' => 1,
        :'234.234.234.234' => 2,
        :'345.345.345.345' => 1
      },
    }

  ```
5. Now we have Path, requestor's IP address, and the count of IP for the path.
6. Analytics class iterates through the log entries and generates statistics that we want to print.
7. Print all the required statistics.
