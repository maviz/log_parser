# Program Flow

The main script file or the execution entry point is the main.rb file.
This has the main class defined, its execute method takes the supplied arguments which is a file 
path and instantiates the FileParser class.

FileParser includes the Validator module which supplies it with the required validation methods.
path provided is validated to be an existant file with the correct extension (i.e .log) otherwise error is displayed.
Once file validated, it is read and validated line by line by the LineParser and as each line is provided to the LineParser instance, 
its return updates the result hash being computed by the FileParser.
After the file is read, A ResutLogger class is given the parser object to display the results on the standard output/console.


# How to Run/Test::::

I assume that you have git cloned the repo.

You can run the script directly from bash by running
`./main.rb [path_to_log_file]` e.g `./main.eb webserver.log`

For test coverage, Rspec has been added and a spec written to cover the validations and calculations.
to run the test, you will need to run `bundle install` first so that rspec and rake could be installed.
A rakefile is added so that we can run the specs via rake by running
`bundle exec rake spec`

