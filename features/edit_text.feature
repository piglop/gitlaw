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
    And I fill "Description" with "Nous ne sommes pas solennels."
    And I replace "proclame solennellement son attachement" with "proclame son attachement" in "Texte modifié"
    And I click on "Enregistrer"
    Then I should see "Constitution française / Pas de cérémonie"
    And I should see "Le peuple français proclame solennellement son attachement aux Droits de l'Homme"
    And I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    And the word "solennellement" should be highlighted
    And the current path should be "/bobby/constitution-francaise/pas-de-ceremonie"

    When I click on "Voir l'original"
    Then the current path should be "/france/constitution-francaise"
    And I should see "Pas de cérémonie"

    Then there should be a git repository in "db/repositories/test/bobby/constitution-francaise.git"
    And the branch "pas-de-ceremonie" should have a file "Constitution française.txt" containing "proclame son attachement"
    And the revision "pas-de-ceremonie^" should have a file "Constitution française.txt" containing "proclame solennellement son attachement"


    When I log out
    When I go to the home page
    And I click on "Constitution française"
    And I click on "Pas de cérémonie"
    And I click on "Proposer une variante"
    Then I should see "Vous devez être connecté"

    When I click on "Créer un compte"
    And I fill the sign up form with name "Mike", identifier "mike", email "mike@example.com" and password "password"
    Then I should see "Création d'une variante"

    When I fill "Titre de la variante" with "Nous sommes déjà attachés"
    And I let the field "Description" empty
    And I replace "proclame son attachement" with "rappelle son attachement" in "Texte modifié"
    And I click on "Enregistrer"
    Then I should see "Constitution française / Nous sommes déjà attachés"
    And I should see "Le peuple français proclame son attachement aux Droits de l'Homme"
    And I should see "Le peuple français rappelle son attachement aux Droits de l'Homme"
    And the word "proclam" should be highlighted
    And the word "rappell" should be highlighted
    And the current path should be "/mike/constitution-francaise/nous-sommes-deja-attaches"
    
    When I click on "Voir l'original"
    Then the current path should be "/bobby/constitution-francaise/pas-de-ceremonie"
    And I should see "Nous sommes déjà attachés"
