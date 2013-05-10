Feature: Create a text
  In order to start working on a new text
  As a citizen
  I want create a text

  Scenario: Create French constitution
    When I go to the home page
    And I click on "Créer un nouveau texte"

    Then I should see "Vous devez être connecté"
    When I click on "Créer un compte"
    And I fill the sign up form with name "France", identifier "france", email "france@example.com" and password "password"
    
    Then I should see "France / Création d'un nouveau texte"

    When I fill "Titre" with "Constitution française"
    And I fill "Description" with "Version officielle consolidée."
    And I fill "Texte" with the content of "db/french_constitution.txt"
    And I click on "Créer le texte"
    
    Then I should see "France / Constitution française"
    And the current path should be "/france/constitution-francaise"
    