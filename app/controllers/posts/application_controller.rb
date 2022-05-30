# frozen_string_literal: true

module Posts
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
  end
end
