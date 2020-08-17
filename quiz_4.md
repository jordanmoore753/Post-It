## 8

1. `rails g migrate create_likes`
2. Set up schema of `likes` table to use polymorphic references.

```ruby
class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :user_id
      t.references :likeable, polymorphic: true
      t.timestamps
    end
  end
end
```
`t.references` will create the `likeable_type` and `likeable_id` columns, which reference the table of the resource which has a like and the actual row of data which has a new like.

## 9

1. First, we'll set up the parent model, `User`.

```rb
class User < ApplicationRecord
  has_many :likes
end
```

2. Set up the `Like` model.

```rb
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
```

3. Set up parent models, `Photo && Video && Post`.

```ruby
class Photo < ApplicationRecord
  has_many :likes, as: :likeable
end
```

```ruby
class Video < ApplicationRecord
  has_many :likes, as: :likeable
end
```

```ruby
class Post < ApplicationRecord
  has_many :likes, as: :likeable
end
```