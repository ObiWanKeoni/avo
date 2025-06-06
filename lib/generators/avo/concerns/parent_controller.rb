module Generators
  module Avo
    module Concerns
      module ParentController
        extend ActiveSupport::Concern

        included do
          class_option "parent-controller",
            desc: "The name of the parent controller.",
            type: :string,
            required: false
        end

        def parent_controller
          return "Avo::ArrayController" if options["array"]
          return "Avo::Core::Controllers::Http" if options["http"]

          options["parent-controller"] || ::Avo.configuration.resource_parent_controller
        end
      end
    end
  end
end
