class Api::V1::BaseController < ApplicationController
    include JsonWebToken
    before_action :authenticate_user!
    
end
