#
class ThroughAttachmentableCallbacks

  def initialize(projectable = nil)
    @projectable = projectable
  end

  def before_save(model)
    model.attachmentizations.each do |a|
      a.through_attachmentable = @projectable.nil? ? model : model.send(@projectable)
    end
  end
end