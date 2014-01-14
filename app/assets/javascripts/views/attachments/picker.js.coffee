class Spbec.Views.AttachmentsPicker extends Backbone.View
  template: JST['attachments/picker']

  events: {
    'click #search-attachments-button' : 'searchAttachments'
  }

  initialize: (options) ->
    @chosen_attachments = options.chosen_attachments


  fetchContentTypes: ->
    @table_view.collection.getContentTypes().done (types) =>
      for type in types
        @$('#content-type-picker').append($('<option>', {
          value: type
          text: type
        }))

  fetchJobTypes: ->
    @job_types = new Spbec.Collections.AttachmentJobTypes()
    @job_types.fetch(
      success: (collection) =>
        for job_type in collection.models
          @$('#job-type-id-picker').append($('<option>', {
            value: job_type.get('id')
            text: job_type.get('title')
          }))
    )

  fetchCategories: ->
    @categories = new Spbec.Collections.AttachmentCategories()
    @categories.fetch(
      success: (collection) =>
        for category in collection.models
          @$('#category-id-picker').append($('<option>', {
            value: category.get('id')
            text: category.get('title')
          }))
    )

  searchAttachments: (e) ->
    e.preventDefault()
    title_or_desc = @$('#title-or-desc-picker').val()
    category_id  = @$('#category-id-picker').val()
    job_type_id  = @$('#job-type-id-picker').val()
    content_type = @$('#content-type-picker').val()
    start_date   = @$('#start-date-picker').val()
    finish_date  = @$('#finish-date-picker').val()


    @table_view.collection.fetch(
      data:
        title_or_desc: title_or_desc
        content_type: content_type
        category_id: category_id
        job_type_id: job_type_id
        start_date: start_date
        finish_date: finish_date
    )

  # we moved button to another dom, so we manually attach event in widget#renderAttachmentsPicker
  attachAttachments: (e) =>
    for view in @table_view.table_item_views
      if view.isChecked()
        @chosen_attachments.add(view.model)

    bootbox.hideAll()

  render: ->
    $(@el).html(@template())
    @$('#start-date-picker').datepicker()
    @$('#finish-date-picker').datepicker()

    @renderAttachmentsTable().done =>
      @fetchCategories()
      @fetchJobTypes()
      @fetchContentTypes()

    return this

  renderAttachmentsTable: ->
    @collection = new Spbec.Collections.Attachments();
    @collection.fetch(
#      data:
#         limit: 10
    ).done =>
      @table_view = new Spbec.Views.AttachmentsTable(
        collection: @collection
        chosen_attachments: @chosen_attachments
        el: @$('#attachments-table')
      ).render()
