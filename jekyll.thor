require "stringex"
class Jekyll < Thor
  desc "new", "create a new post"
  method_option :editor, :default => "subl"
  def new(*title)
    title = title.join(" ")
    now = Time.now
    filedate = now.strftime('%Y-%m-%d')
    filename = "_posts/#{filedate}-#{title.to_url}.markdown"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{now}"
      post.puts "tags:"
      post.puts "categories:"
      post.puts "---"
    end

    system(options[:editor], filename)
  end
end