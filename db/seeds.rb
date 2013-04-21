# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

french_constitution = LawText.where(title: "Constitution française").first_or_initialize
french_constitution.text = Rails.root.join('db', 'french_constitution.txt').read
french_constitution.save!
