Feature: Edit a text
  In order to suggest a new text
  As a citizen
  I want write a modified text

  Scenario: First edit
    Given there's a user "France" with identifier "france"
    And there's a text "Constitution française" with identifier "constitution-francaise" and the content of "db/french_constitution.txt" owned by user "france"
    And the text "constitution-francaise" is featured

    When I go to the home page
    And I click on "Constitution française"
    Then I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"

    When I click on "Proposer une variante"
    Then I should see "Vous devez être connecté"

    When I click on "Créer un compte"
    And I fill the sign up form with name "Bobby", identifier "bobby", email "bob@example.com" and password "password"
    Then I should see "Création d'une variante"

    When I fill "Titre de la variante" with "Pas de cérémonie"
    And I fill "Motivation" with "Nous ne sommes pas solennels."
    And I replace "proclame solennellement son attachement" with "proclame son attachement" in "Texte modifié"
    And I click on "Enregistrer"
    Then I should see "Constitution française / Pas de cérémonie"
    And I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    And I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    And the word "solennellement" should be highlighted
    And the current path should be "/bobby/constitution-francaise/pas-de-ceremonie"

    When I click on "Constitution française"
    Then I should see "Pas de cérémonie"

    Then there should be a git repository in "db/repositories/test/bobby/constitution-francaise.git"
    And the branch "pas-de-ceremonie" should have a file "Constitution française.txt" containing "proclame son attachement"
    And the revision "pas-de-ceremonie^" should have a file "Constitution française.txt" containing "proclame solennellement son attachement"
