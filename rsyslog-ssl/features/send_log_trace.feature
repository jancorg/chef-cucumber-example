Feature: Server can send log traces to remote rsyslogd server

  In order to parse and retain log traces
  As a system engineer 
  I want system logs centralized in one server


  Background: 

  Given I have provisioned the following infrastructure:
    | Server Name | Operating System | Version | Chef Version | Run List       |
    | rsyslog-server | ubuntu           |   12.04 |       11.4.4 | rsyslog-wrapper::server |
    | rsyslog-client | ubuntu           |   12.04 |       11.4.4 | rsyslog-wrapper::client |
    And I have run Chef

  
  Scenario: Log trace is sent to remote log server
    Given a test user 'cejacas'
    When user logins via SSH
    Then remote log server should register login fail
