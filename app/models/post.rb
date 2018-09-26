class Post < ApplicationRecord

  def self.standard_serialize(total)
    columns_to_serialize = [:full_name, :summary, :body]
    self.limit(total).map do |post|
      post.as_json(only: columns_to_serialize)
    end.to_json
  end

  def self.sql_serialize(total)
    query = <<-SQL
      WITH ordered_posts as (
        SELECT full_name, summary, body, id
        FROM posts
        ORDER BY id ASC
        LIMIT #{total}
      )

      SELECT
        json_agg(
          json_build_object(
            'full_name', full_name,
            'summary', summary,
            'body', body
          )
        )
      FROM ordered_posts
    SQL
    connection.execute(query).values[0][0]
  end
end
