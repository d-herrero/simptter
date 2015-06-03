class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper ApplicationHelper

  before_action :authenticate_user!, unless: :is_public_page?
  before_action :locale, unless: :is_api?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def locale
      # Get
      I18n.locale = cookies[:locale] unless cookies[:locale].blank?
      # Set
      if params.include? :locale and not params[:locale].blank?
        I18n.locale = params[:locale]
        cookies[:locale] = params[:locale]
        begin
          redirect_to :back
        rescue
          redirect_to '/'
        end
      end
    end

    def is_public_page?
      if SIMPTTER_CONFIG['public_pages'].include? params[:controller]
        public_pages = SIMPTTER_CONFIG['public_pages'][params[:controller]]
        not public_pages[0].blank? and (not public_pages[0].include? 'actions' or (public_pages[0].include? 'actions' and ((public_pages[0]['actions'].is_a? Array and public_pages[0]['actions'].include? params[:action]) or (public_pages[0]['actions'].is_a? String and public_pages[0]['actions'] == params[:action]))))
      else
        false
      end
    end

    def is_api?
      is_public_page? and params[:action][0..-4] == 'api_' and response.format.json?
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push :name
      devise_parameter_sanitizer.for(:account_update).push :name
    end
end