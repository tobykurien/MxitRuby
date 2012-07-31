require 'rubygems'
require 'sinatra'
require 'ruty'
require 'modules/mxit/mxit'

@@loader = nil

before do
  @@loader = Ruty::Loaders::Filesystem.new(:dirname => './views') if @@loader == nil

  # Strip the last / from the path
  request.env['PATH_INFO'].gsub!(/\/$/, '')
  @mxit = Mxit.new request.env
end

get '/event_details/:e_uri' do |e_uri|
  do_render :coming_soon, :message => "coming soon for #{e_uri}"
end

get '' do
  data = {
    :mxit => @mxit,
    :events => [ 
        { :uri => 1, :name => "Test event 1" }, 
        { :uri => 2, :name => "Test event 2" } 
    ]
  }

  do_render :index, data
end

private

def do_render(template, obj)
    obj = { :root => @env['SCRIPT_NAME'] + "/" }.merge obj # add root variable
    @@loader.get_template(template.to_s + ".html").render(obj)
end

