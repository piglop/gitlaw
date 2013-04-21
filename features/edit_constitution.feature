Feature: Edit the constitution
  In order to suggest a new constitution
  As a citizen
  I want write a modified constition

  Scenario: First edit
    When I go to the home page
    And I click on "Constitution française"
    Then I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    When I click on "Créer une autre version"
    Then I should see "Vous devez être connecté"
    When I click on "Créer un compte"
    And I fill the sign up form with "bob@example.com" and "password"
    Then I should see "Création d'une version alternative"
    And I should see a text area containing "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    When I replace "Le peuple français proclame solennellement son attachement aux Droits de l'Homme" with "Le peuple français proclame son attachement aux Droits de l'Homme"
    And I click on "Enregistrer"
    Then I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    When I click "Comparer avec l'originale"
    Then I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    And I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    And the word "solennellement" should be highlighted
    