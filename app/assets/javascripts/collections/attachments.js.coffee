class Spbec.Collections.Attachments extends Backbone.Collection
  url: Routes.attachments_path()
  model: Spbec.Models.Attachment

  getContentTypes: ->
    $.trafficCop(Routes.attachments_content_types_path())

  update: (data) ->
    @set(data)
