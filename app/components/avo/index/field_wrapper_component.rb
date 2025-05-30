# frozen_string_literal: true

class Avo::Index::FieldWrapperComponent < Avo::BaseComponent
  prop :field
  prop :resource
  prop :dash_if_blank, default: true
  prop :center_content, default: false
  prop :flush, default: false
  prop :args, kind: :**, default: {}.freeze

  def after_initialize
    @view = Avo::ViewInquirer.new("index")
    @classes = @args.dig(:class) || ""
  end

  def classes
    result = @classes

    unless @flush
      result += " py-3"
    end

    result += " #{@field.get_html(:classes, view: @view, element: :wrapper)}"

    result
  end

  def style
    @field.get_html(:style, view: @view, element: :wrapper)
  end

  def stimulus_attributes
    attributes = {}

    @resource.get_stimulus_controllers.split(" ").each do |controller|
      attributes["#{controller}-target"] = "#{@field.id.to_s.underscore}_#{@field.type.to_s.underscore}_wrapper".camelize(:lower)
    end

    wrapper_data_attributes = @field.get_html :data, view: @view, element: :wrapper
    if wrapper_data_attributes.present?
      attributes.merge! wrapper_data_attributes
    end

    attributes
  end

  def render_dash?
    if @field.type == "boolean"
      @field.value.nil?
    else
      @field.value.blank? && @dash_if_blank
    end
  end
end
