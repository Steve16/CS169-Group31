  Feature: user can create accounts

    As a student
    So that I can track my progress
    I want to be able to log back in

  Scenario: logging in (sad path)
    When I go to the login page
    And I press "Submit"
    Then I should see "Invalid email and/or password! Please try again!"

  Scenario: creating a new account
    When I am on the sign up page
    And I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Johnson"
    And I fill in "user_email" with "john@johnson.com"
    And I fill in "user_password" with "12345"
    And I fill in "user_password_confirmation" with "12345"
    And I press "Submit"
    Then I should be on the survey page

  Scenario: creating a new account (sad path)
    Given that there is a user with the following email: "john@johnson.com"
    When I am on the sign up page
    And I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Johnson"
    And I fill in "user_email" with "john@johnson.com"
    And I fill in "user_password" with "12345"
    And I fill in "user_password_confirmation" with "12345"
    And I press "Submit"
    Then I should be on the sign up page

  Scenario: incorrect password confirmation
    When I am on the sign up page
    And I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Johnson"
    And I fill in "user_email" with "john@johnson.com"
    And I fill in "user_password" with "12345"
    And I fill in "user_password_confirmation" with "23456"
    And I press "Submit"
    Then I should be on the sign up page

  Scenario: signing out
    Given all the profiles exist
    Given that there is a user with the following email: "john@johnson.com"
    When I go to the login page
    And I fill in "session_email" with "john@johnson.com"
    And I fill in "session_password" with "12345"
    And I press "Submit"
    Then I should be on the home login page
    When I follow "Logout" 
    Then I should be on the home page

  Scenario: going to the edit page
    Given all the profiles exist
    When I am on the sign up page
    And I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Johnson"
    And I fill in "user_email" with "john@johnson.com"
    And I fill in "user_password" with "12345"
    And I fill in "user_password_confirmation" with "12345"
    And I press "Submit"
    Then I should be on the survey page
    When I fill in "type_type" with "ISTJ"
    And I press "Enter"
    Then I should be on the home login page
    When I follow "Student Panel"
    Then I should be on the user edit page
    And I should see "Please enter the code your professor gave you"


  
    
    
