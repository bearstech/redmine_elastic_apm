module RedmineElasticAPM
  module Patches
    module ApplicationControllerPatch
      def user_setup
        super
        ElasticAPM.set_user(User.current)
      end
      def find_project(project_id=params[:id])
        super
        ElasticAPM.set_custom_context({
          project: @project
        })
        ElasticAPM.set_custom_context({
          foo: "bar"
        })
      end
    end
  end
end

unless ApplicationController.included_modules.include?(RedmineElasticAPM::Patches::ApplicationControllerPatch)
  ApplicationController.prepend(RedmineElasticAPM::Patches::ApplicationControllerPatch)
end
