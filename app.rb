require 'sinatra'

Post = Struct.new :date, :title, :content

get "/" do
  filenames = Dir.glob("posts/*")
  @posts = []

  filenames.each do |f|
    file = [*File.open(f)].reject { |l| l == "\n" }
    @posts << Post.new(file.shift.chomp, file.shift.chomp, file.join('').chomp)
  end
  @posts.sort! { |a, b| b.date <=> a.date }

  haml :index
end
