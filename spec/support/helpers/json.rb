class JsonHelper
  attr_accessor :model_name

  def initialize(model_name)
    @model_name = model_name
  end

  def json_headers
    JSON.parse(File.read('spec/fixtures/json_headers.json'))
  end

  def successful_post
    File.read("spec/fixtures/#{@model_name}/post.json")
  end

  def successful_put(model_id)
    File.read("spec/fixtures/#{@model_name}/put.json")
  end
end
