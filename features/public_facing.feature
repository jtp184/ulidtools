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
And I send the to_s message to the ULID
Then I should recieve a ULID formatted String

# ==================================================
Scenario: Returning the bytestring

Given I have a ULID
And I send the raw message to the ULID
Then I should recieve a bytes formatted String

# ==================================================
Scenario: Returning a UUID Formatted String

Given I have a ULID
And I send the to_uuid message to the ULID
Then I should recieve a UUID formatted String

# ==================================================
Scenario: Returning the time component

Given I have a ULID
And I send the time message to the ULID
When I check the time result
Then it should be correct

# ==================================================
Scenario: Generating a ULID at a specific time

Given I want to generate a ULID
But I want it to be created at a specific time
When I check that the time returned is the time entered
Then it should be correct

# ==================================================
Scenario: Convering a UUID into a ULID

Given I have a UUID
When I parse the UUID
Then I should recieve a new ULID