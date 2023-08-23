class Api::V1::BaseController < ApplicationController
    layout "v1"
    include JsonWebToken
    before_action :authenticate_user!
end
