# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

france = User.seed :name do |s|
  s.name = "France"
  s.slug = "france"
end.first

french_constitution = Constitution.seed :slug do |s|
  s.title = "Constitution"
  s.slug = "france-constitution"
  s.text = Rails.root.join('db', 'french_constitution.txt').read
  s.user = france
end.first

FeaturedConstitution.seed :constitution_id do |s|
  s.constitution_id = french_constitution.id
end

