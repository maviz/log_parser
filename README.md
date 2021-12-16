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
`./main.rb [path_to_log_file]` e.g `./main.rb webserver.log`

For test coverage, Rspec has been added and specs are written to test the validations and calculations.
to run the test, you will need to run `bundle install` first so that rspec and rake could be installed.
A rakefile is added so that we can run the specs via rake by running
`bundle exec rake spec`


# Rubocop
you can also test rubocop by running `rubocop` in the project directory after `bundle install`.


# Ruby version
Gemfile has no mention of ruby version so any stable version could be used, I hope you won't use a very old one as I havn't tested on < 2 ruby version.



