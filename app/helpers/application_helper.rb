# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    mapping = {
      notice: 'alert alert-info',
      success: 'alert alert-success',
      error: 'alert alert-error',
      alert: 'alert alert-error'
    }
    mapping[level.to_sym]
  end
end
