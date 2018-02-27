# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = %w{alice bob mallory}.map do |username|
  [
    username.to_sym,
    User.create({
      email: "#{username}@autoseg.com",
      password: '123456',
    })
  ]
end

task_relations = [
  { public: false },
  { public: true },
].product(users).each do |task_relation_data, user_data|
  username, user = user_data
  task_relation = TaskRelation.create({
    user_id: user.id,
    public: task_relation_data,
  })
  Task.create(
    10.times.map do |i|
      public_state = task_relation_data[:public] ? 'public' : 'private'
      closed = i % 4 == 1
      {
        description: "user #{username} #{public_state} task ##{i + 1}",
        task_relation: task_relation,
        closed: closed,
      }
    end
  )

end