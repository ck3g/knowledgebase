# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new email: "admin@example.com",
                 username: "admin",
                 password: "password",
                 password_confirmation: "password"

admin.need_invitation = false
5.times { admin.invite_codes.build }
admin.roles << Role.new(name: "admin")
admin.save


5.times do
  tags = []
  3.times { tags << Faker::Lorem.word }
  Skill.create(name: Faker::Name.title,
               description: Faker::Lorem.paragraphs.join("\n"),
               user: admin,
               tags: tags
              )
end
