require 'rubygems'
require 'sinatra'
require 'ruty'
require 'modules/mxit/mxit'

@@loader = nil

# this gets called before each request is processed
before do
  # create Ruty template engine instance
  @@loader = Ruty::Loaders::Filesystem.new(:dirname => './views') if @@loader == nil

  # Strip the last / from the path
  request.env['PATH_INFO'].gsub!(/\/$/, '')
  
  # create mxit object
  @mxit = Mxit.new request.env
end

# sample event details link
get '/event_details/:e_uri' do |e_uri|
  do_render :coming_soon, :message => "coming soon for #{e_uri}"
end

# sample landing page
get '' do
  data = {
    :events => [ 
        { :uri => 1, :name => "Test event 1" }, 
        { :uri => 2, :name => "Test event 2" } 
    ]
  }

  do_render :index, data
end

private

# render templates
def do_render(template, obj)
    # add global template variables
    obj = { :root => @env['SCRIPT_NAME'] + "/", :mxit => @mxit }.merge obj 
    # use ruty to render templates from symbol name
    @@loader.get_template(template.to_s + ".html").render(obj)
end

