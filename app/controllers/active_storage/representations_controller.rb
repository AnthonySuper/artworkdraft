# frozen_string_literal: true

module ActiveStorage
  class RepresentationsController < BaseController
    include ActiveStorage::SetBlob

    def show
      expires_in 1.year, public: true
      variant = @blob.representation(params[:variation_key]).processed
      send_file_headers!(type: @blob.content_type || DEFAULT_SEND_FILE_TYPE,
                         disposition: 'inline')
      self.response_body = Enumerator.new do |f|
        @blob.service.download(variant.key) do |chunk|
          f << chunk
        end
      end
    end
  end
end
