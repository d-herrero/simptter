module ApplicationHelper
  include DateTimeHelper

  def render_error(status, raw_message = true)
    if Rails.env == 'production' or @response.blank? or @exception.blank?
      status = "status_#{status}" if status.is_a? Integer
      status = 'status_500' unless i18n_data[:errors][:pages].include? status.to_sym
      title = I18n.t("errors.pages.#{status}.title")
      message = I18n.t("errors.pages.#{status}.text")
    else
      title = "#{@response} (#{status})"
      message = @exception
    end

    render '/shared/errors', layout: false, locals: { title: title, message: message, raw_message: raw_message }
  end

  def i18n_data
    I18n.backend.send(:init_translations) unless I18n.backend.initialized?
    I18n.backend.send(:translations)[I18n.locale]
  end
end