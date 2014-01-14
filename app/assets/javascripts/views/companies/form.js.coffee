class Spbec.Views.CompanyForm extends Backbone.View

  events: {
    'submit form' : 'save'
  }
  
  initialize: ->
    Backbone.Form.setTemplates({
      companyForm: JST['companies/form']
    });
    
  save: (e) ->
    e.preventDefault()
    errors = @form.commit()
    if errors is undefined
      @model.save().done(=>
        $("#tcp_company_id").append($('<option>', {
          value: @model.get('id')
          text: @model.get('title')
        }));
        notify('Новая компания успешно добавлена!')
        bootbox.hideAll();
      )
  render: ->
    @form = new Backbone.Form(
      model: @model
      template: 'companyForm'
      serverSideErrors: true
    ).render()
    $(@el).html(@form.el)

    return this