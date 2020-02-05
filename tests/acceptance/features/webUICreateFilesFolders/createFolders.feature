Feature: create folders
  As a user
  I want to create folders
  So that I can organise my data structure

  Background:
    Given user "user1" has been created with default attributes
    And user "user1" has logged in using the webUI
    And the user has browsed to the files page

  @smokeTest
  Scenario: Create a folder inside another folder
    When the user creates a folder with the name "top-folder" using the webUI
    And the user opens folder "top-folder" using the webUI
    Then there should be no resources listed on the webUI
    When the user creates a folder with the name "sub-folder" using the webUI
    Then folder "sub-folder" should be listed on the webUI
    When the user reloads the current page of the webUI
    Then folder "sub-folder" should be listed on the webUI

  Scenario: Create a folder with default name
    When the user creates a folder with default name using the webUI
    Then folder "New folder" should be listed on the webUI

  Scenario: Try to create a folder without name
    When the user creates a folder without name using the webUI
    Then the error message 'Folder name cannot be empty' should be displayed on the webUI dialog prompt

  Scenario: Try to create a folder with existing name
    When the user creates a folder with the invalid name "simple-folder" using the webUI
    Then the error message 'simple-folder already exists' should be displayed on the webUI dialog prompt

  Scenario: Try to create a folder with invalid name
    When the user creates a folder with the invalid name "../folder" using the webUI
    Then the error message 'Folder name cannot contain "/"' should be displayed on the webUI dialog prompt

  Scenario: Try to create a folder with another invalid name
    When the user creates a folder with the invalid name "folder/subfolder" using the webUI
    Then the error message 'Folder name cannot contain "/"' should be displayed on the webUI dialog prompt

  @issue-2467
  Scenario: Create folder with special characters in its name and browse to that folder
    When the user creates a folder with the name "?&%0" using the webUI
    And the user opens folder "?&%0" using the webUI
    And the user reloads the current page of the webUI
    Then the page should be empty
  # Then the files table should be displayed

  @skip @yetToImplement
  Scenario: Create a folder in a public share
    Given the user has created a new public link for folder "simple-empty-folder" using the webUI with
      | permission | read-write |
    And the public accesses the last created public link using the webUI
    When the user creates a folder with the name "top-folder" using the webUI
    And the user opens folder "top-folder" using the webUI
    Then there should be resources files/folders listed on the webUI
    When the user creates a folder with the name "sub-folder" using the webUI
    Then folder "sub-folder" should be listed on the webUI
    When the user reloads the current page of the webUI
    Then folder "sub-folder" should be listed on the webUI
