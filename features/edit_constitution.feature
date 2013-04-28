Feature: Edit the constitution
  In order to suggest a new constitution
  As a citizen
  I want write a modified constition

  Scenario: First edit
    When I go to the home page
    And I click on "Constitution française"
    Then I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    When I click on "Proposer une amélioration"
    Then I should see "Proposition d'une amélioration"
    When I replace "proclame solennellement son attachement" with "proclame son attachement" in "Texte"
    And I click on "Enregistrer"
    Then I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    When I click "Comparer avec l'originale"
    Then I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    And I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    And the word "solennellement" should be highlighted
