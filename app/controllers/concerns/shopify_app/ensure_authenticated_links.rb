# frozen_string_literal: true

module ShopifyApp
  module EnsureAuthenticatedLinks
    extend ActiveSupport::Concern

    included do
      before_action :redirect_to_splash_page, if: :missing_expected_jwt?
    end

    private

    def redirect_to_splash_page
      splash_page_path = root_path(return_to: request.fullpath, shop: current_shopify_domain)
      redirect_to(splash_page_path)
    end

    def missing_expected_jwt?
      jwt_shopify_domain.blank?
    end
  end
end
