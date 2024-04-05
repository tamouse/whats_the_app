  # Apple Coding Assignment 2024-04-04
  
## Project Requirements

### Coding Assignment Requirements:

- Must be done in Ruby on Rails  
- Accept an address as input  
- Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)  
-  Display the requested forecast details to the user  
-  Cache the forecast details for 30 minutes for all subsequent requests by zip codes.  
- Display indicator if result is pulled from cache.  

### Assumptions:  
- This project is open to interpretation  
- Functionality is a priority over form  
- If you get stuck, complete as much as you can  

### Submission:  
- Use a public source code repository (GitHub, etc) to store your code  
- Send us the link to your completed code  

## Project Directions

The Apple Coding Assessment Exercise is attached. Please return as a single GitHub Link with the Code, ReadMe file, and Unit Tests in it.  

Please remember – it’s not just whether or not the code works that they will be focused on seeing – it’s all the rest of what goes into good Senior Software Engineering daily practices for Enterprise Production Level Code – such as specifically:  

- Unit Tests ( on the list of things people forget to include – so please remember, treat this as if it were true production level code, do not treat it just as an exercise),  
- Detailed Comments/Documentation within the code, also have a README file  
- Include *Decomposition* of the Objects in the Documentation  
- Design Patterns (if/where applicable)  
- Scalability Considerations (if applicable)  
- Naming Conventions (name things as you would name them in enterprise-scale production code environments)  
- Encapsulation, (don’t have 1 Method doing 55 things)  
- Code Re-Use, (don’t over-engineer the solution, but don’t under-engineer it either) 
- and any other industry Best Practices.  

Using ChatGPT, Copilot, or any other AI tools to complete the assignment or to use during your interview is not allowed.  

## Methodology
- Find a free and easy weather API. Probably weather.gov.
- Create a gem with an executable.
- Create a public Github repo.
- Branch iteration-1: getting the weather data
- use TDD
- need VCR? maybe
- Meeting the decomposition criterion: start with a single executable that does everything. Decompose (refactor into smaller objects/classes) in subsequent iterations, along with tests.
- Include documentation
- Do a few rounds of refinement and refactoring, documenting along the way in branch iterations.
- Add some features beyond just the current temp, as the API allows.
- Follow the same test, code, decompose cycle for each iteration

## Weather API

#### weather.gov
- From the weather.gov api site, you can obtain the weather for a given set of lat-long coordinates.
- Discovery of lat-long might be an issue, short of using geolocation based on the address (zip code)
- The weather.gov site requires lat-long, and that's a bit too much trouble to get

#### weatherapi.com
- Requires a signup to get an API.
- Takes all kinds of address like things:
  - US Zipcode,
  - UK Postcode,
  - Canada Postalcode,
  - IP address,
  - Latitude/Longitude (decimal degree) or
  - city name.
- Free as well. except for the signup

## Credentials
- If I don't want to make the reviewers sign up, I'll need to pass the API key as a secrets file.
  - [ActiveSupport::EncryptedConfiguratioh](https://api.rubyonrails.org/files/activesupport/lib/active_support/encrypted_configuration_rb.html) might be the answer to that.
- Check for other gems, too
  - [dry-credentials](https://github.com/svoop/dry-credentials?tab=readme-ov-file) - lighter weight
  - the other recent ones look like they are for specific credential managers, e.g. AWS Secrets Manager; that's a bit too far over-engineered!
	
## Initial Set up

running 
	    
```shell
bundle gem whats_the_temp --exe --no-coc --no-mit --test=minitest --ci=github --linter=rubocop -e
# Edit the gemspec
cd whats_the_app
bundle
git add --all --verbose
git commit --message 'initial commit ...'
gh repo create whats_the_app -d 'Ruby CLI app to show the current temp' \
  --disable-issues --disable-wiki -h 'https://github.com/tamouse/whats_the_temp' \
  --public --remote=origin --source=.
git push origin HEAD
```

Lots of little things to get GH CI green:
- configure the rubocops for minitest and rake correctly
- modify the failing test that minitest inserts by default
- add the architecture so GH can run its CI

Easy to have rubocop fix up problems.

## Iteration 1: Saving the credential

Install `dry-credentials`
- Make sure to add the cert before running `bundle install`

Run bundler with

    bundle install --trust-policy MediumSecurity

Extend the app with the dry-credentials library
- I'm not sure this is worth it: hiding one secret and creating another secret that has to be configured / shared with reviewers to run the damn script!
- *__Backing out of this branch.__*

## Iteration 1.b: instead of managing the credential in code

- Require an environment variable with the API key
- Creating the weather API client class
- utility methods for constructing the correct URL, and for fetching the data
- main method to retrieve the current temp in Fahrenheit
- *potential future option for Celcius*

## Iteration 2: Include VCR to keep from hitting the endpoint during testing
- **Especially** important with GH CI to not hit the endpoint too often, and not needed for unit tests
- Updated GH workflow to run on all pushes
- Created a repo secrets database and added the `WEATHER_API_KEY` to it
- CI is GREEN ✅

## Iteration 3: wire up the CLI
- Start from `ARGV[0]`
- Create a CLI class to handle inputs and outputs
- Take in `ARGV`
- Emit a formatted string (but don't print it, the exe file will do that)
- Have a `USAGE` string
- Respond to `-h` and `--help`
- Print the `USAGE` string to `stderr` if no argument given
- Add error reporting to `WeatherApi`?

## Iteration 4: command line testing
- Put argument plus IO in a class
- The class take the 3 standard IO, args, and a future-proof options arguments
- The test creates StringIO standins for the 3 standard IO objects and checks their content after the run

## Iteration 5: README and documentation
- Update the README with more appropriate info
- Create this document to show the approach taken



