require 'pg'

class Bookmark

    attr_reader :id, :url, :title

    def initialize(id:, url:, title:)
      @id = id
      @title = title
      @url = url
    end

    def self.all
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'bookmark_manager_test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end

      result = connection.exec("SELECT * FROM bookmarks;")
      result.map { |bookmark| Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])}
    end

    def self.create(url:, title:)
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'bookmark_manager_test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}');")
    end

    def self.delete(id:)
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'bookmark_manager_test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end
      
      connection.exec("DELETE FROM  bookmarks WHERE  id = '#{id}';")
    end

end
