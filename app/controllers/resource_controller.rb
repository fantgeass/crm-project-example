class ResourceController < ApplicationController
  inherit_resources

  # draper inherited resources
  protected
  def collection
    get_collection_ivar || set_collection_ivar(super.decorate)
  end

  def resource
    get_resource_ivar || set_resource_ivar(super.decorate)
  end

  def build_resource
    get_resource_ivar || set_resource_ivar(super.decorate)
  end

  def choose_parent_layout
    parent.is_a?(Project) ? 'projects' : 'tcps'
  end
end
