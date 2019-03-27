module RedmineElasticAPM
  module Patches
    module ApplicationControllerPatch
      def user_setup
        super
        ElasticAPM.set_user(User.current)
      end
    end
  end
end

unless ApplicationController.included_modules.include?(RedmineElasticAPM::Patches::ApplicationControllerPatch)
  ApplicationController.prepend(RedmineElasticAPM::Patches::ApplicationControllerPatch)
end
