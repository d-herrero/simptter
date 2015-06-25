class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper ApplicationHelper

  before_action :authenticate_user!, unless: :is_public_page?
  before_action :locale, unless: :is_api?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from StandardError, :with => :render_error_for_exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_error_for_exception
  rescue_from ActiveRecord::ActiveRecordError, :with => :render_error_for_exception
  rescue_from ActionController::RoutingError, :with => :render_error_for_exception
  rescue_from ActionController::UnknownController, :with => :render_error_for_exception
  rescue_from ::AbstractController::ActionNotFound, :with => :render_error_for_exception
  rescue_from ActionController::UnknownFormat, :with => :render_error_for_exception

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
      is_public_page? and params[:action][0..3] == 'api_'
    end

    def render_error_for_exception(exception)
      if Rails.application.config.consider_all_requests_local
        exceptions_status_codes = {
          'ActionController::UnknownFormat' => 400,
          'ActiveRecord::ActiveRecordError' => 401,
          'ActiveRecord::RecordNotFound' => 404,
          'ActionController::RoutingError' => 404,
          'ActionController::UnknownController' => 404,
          '::AbstractController::ActionNotFound' => 404,
          'StandardError' => 500
        }
        status_code = exceptions_status_codes.include?(exception.to_s) ? exceptions_status_codes[exception.to_s] : 500

        render_error status_code
      else
        raise exception
      end
    end

    def api_respond(data)
      request.format = 'json' unless params[:format]

      respond_to do |format|
        format.json do
          render :json => data
        end
      end
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push :name
      devise_parameter_sanitizer.for(:account_update).push :name
    end
end