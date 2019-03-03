Feature: Public Facing API

The public API should be easy to use, and conform whenever possible to similar tools.

# ==================================================
Scenario: Generating a new ULID

Given I want to generate a ULID
And I send the generate message to the generator
Then I should recieve a new ULID

# ==================================================
Scenario: Returning the Lexical string

Given I have a ULID
And I send the string message to the ULID
Then I should recieve a ULID formatted String

# ==================================================
Scenario: Returning the bytestring

Given I have a ULID
And I send the bytestring message to the ULID
Then I should recieve a bytes formatted String

# ==================================================
Scenario: Returning a UUID Formatted String

Given I have a ULID
And I send the UUID message to the ULID
Then I should recieve a UUID formatted String

# ==================================================