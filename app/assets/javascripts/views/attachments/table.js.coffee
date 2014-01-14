class Spbec.Views.AttachmentsTable extends Backbone.View
  template: JST['attachments/table']

  initialize: (options) ->
    @chosen_attachments = options.chosen_attachments

    _.bindAll(@, 'render')
    @collection.on('add', @render)
    @collection.on('sync', @render)
    @collection.on('remove', @render)

  render: ->
    $(@el).html(@template())
    @renderTableItems()
    return this

  renderTableItems: ->
    @table_item_views = []

    for attachment in @collection.models
      if (@chosen_attachments.find((chosen) -> chosen.get('id') == attachment.get('id')))
        disabled = true
      else
        disabled = false

      view = new Spbec.Views.AttachmentsTableItem(
        model: attachment
        disabled: disabled
      ).render()

      @table_item_views.push(view)
      @$('tbody').append(view.el)