Feature: Partners can read my page

  In order to show how to do an acceptance test in chef
  As a system engineer
  I want a simple webpage to deploy and show


  Background:

    Given I have provisioned the following infrastructure:
    | Server Name | Operating System | Version | Chef Version | Run List       |
    | simpleWeb   | ubuntu           |   12.04 |       11.4.4 | webpage::default |
    And I have run Chef


  Scenario: Partner visits my page
    Given a url "http://simpleweb.local"
    When a web user browses to the URL
    Then the user should see "Hi there"




