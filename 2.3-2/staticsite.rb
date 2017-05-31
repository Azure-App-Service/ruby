require 'webrick'
options = {
    :Port => ENV["PORT"].to_i,
    :DirectoryIndex => ["hostingstart.html"],
    :DocumentRoot => '.'
}
WEBrick::HTTPServer.new(options).start
