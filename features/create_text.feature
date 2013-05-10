Feature: Create a text
  In order to start working on a new text
  As a citizen
  I want create a text

  Scenario: Create French constitution
    When I go to the home page
    And I click on "Créer un nouveau texte"
    Then I should see "Création d'un nouveau texte"
