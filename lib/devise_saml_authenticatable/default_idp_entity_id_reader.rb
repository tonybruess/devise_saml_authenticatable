module DeviseSamlAuthenticatable
  class DefaultIdpEntityIdReader
    include DeviseSamlAuthenticatable::SamlConfig

    def self.entity_id(params)
      if params[:SAMLRequest]
        OneLogin::RubySaml::SloLogoutrequest.new(
          params[:SAMLRequest],
          settings: new.saml_config(),
          allowed_clock_drift: Devise.allowed_clock_drift_in_seconds,
        ).issuer
      elsif params[:SAMLResponse]
        OneLogin::RubySaml::Response.new(
          params[:SAMLResponse],
          settings: new.saml_config(),
          allowed_clock_drift: Devise.allowed_clock_drift_in_seconds,
        ).issuers.first
      end
    end
  end
end
