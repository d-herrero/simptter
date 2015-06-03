unless %w(development test).include? Rails.env
  I18n.backend.class.send(:include, I18n::Backend::Fallbacks)

  # In production environment, if the current locale doesn't contain the string we're looking for, we fallback to the default one
  SIMPTTER_CONFIG['locale']['list'].each do |x|
    I18n.fallbacks[x['id']] = SIMPTTER_CONFIG['locale']['default'] unless x['id'] == SIMPTTER_CONFIG['locale']['default']
  end
end