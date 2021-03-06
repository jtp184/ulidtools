Feature: Underlying Representation

Needs to rigorously conform to spec, and not promise behavior we don't have

# ==================================================
Scenario: Creates valid Crockford

Given I have a ULID
And I send the to_s message to the ULID
When I check if it is valid Crockford
Then it is correct

# ==================================================
Scenario: Proper sorting order

Given I have two ULIDs
And I compare them
When I check the sort order of the result
Then it is correct

# ==================================================
Scenario: Timestamp is stored in the first 10 bytes

Given I have a ULID
And I check the first 10 bytes
When I check if they equate to a time
Then they are correct

# ==================================================
Scenario: Randomness is stored in the last 10 bytes

Given I have a ULID
And I check the last 10 bytes
When I check if they are random bits
Then they are correct

# ==================================================
Scenario: Timestamp returned is binary accurate

Given I have a ULID
But I want it to be created at a specific time
When I check that the binary timestamp is accurate
Then it should be correct

# ==================================================
Scenario: UUIDs produced translate back into ULIDs correctly

Given I have a unique ULID and UUID
When I compare the UUID and ULID
Then they should be correct