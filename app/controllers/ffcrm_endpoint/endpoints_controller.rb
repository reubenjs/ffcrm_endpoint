module FfcrmEndpoint

  class EndpointsController < ActionController::Base

    respond_to :json, :js, :html

    def consume
      if endpoint.authenticate
        begin
          endpoint.process
          respond_with('', location: nil, status: 201)
        rescue RuntimeError => e
          respond_with(e.message, location: nil, status: 500)
        end
      else
        respond_with('', location: nil, status: :unauthorized)
      end

    end

    private

    def endpoint
      @endpoint ||= FfcrmEndpoint::Endpoint.new(request)
    end

  end

end
