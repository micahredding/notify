require "iconv"

class EmailBodyBuilder

  def initialize email
    @email = email
    @message = email.message
    @body = ""
  end

  def build
    if @message.multipart?
      build_content_multipart
    else
      build_content_singlepart
    end

    @body
  end

  private

  def build_content_singlepart
    @body = build_content(@message.body)
  end

  def build_content_multipart
    @message.parts.each do |part|
      @body << build_content(part.body)
    end
  end

  def build_content body
    Iconv.conv("UTF-8//IGNORE", "US-ASCII", body.decoded)
  end

end