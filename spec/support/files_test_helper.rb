module FilesTestHelper
  extend self

  def png_name
    "img.png"
  end

  def png
    upload(png_name, "image/png")
  end

  private

  def upload(name, type)
    file_path = Rails.root.join("spec", "support", "assets", name)
    f = Rack::Test::UploadedFile.new(file_path, "image/png", :binary)
  end
end
