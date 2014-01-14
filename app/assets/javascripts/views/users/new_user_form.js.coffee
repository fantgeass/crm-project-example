class Spbec.Views.NewUserForm extends Backbone.View

  events: {
   'submit form' : 'save'
  }

  initialize: ->
    Backbone.Form.setTemplates({
     newUserForm: JST['users/new_user_form']
    });

  save: (e) ->
    e.preventDefault()
    errors = @form.commit()
    if errors is undefined
      @model.save().done(=>
        $("#tcp_client_id").append($('<option>', {
          value: @model.get('id')
          text: @model.get('fullname')
        }));
        notify('Новый пользователь успешно добавлен!')
        bootbox.hideAll();
      )

  render: ->
    @form = new Backbone.Form(
      model: @model
      template: 'newUserForm'
      schema: @model.getNewUserFormSchema()
      serverSideErrors: true
    ).render()
    $(@el).html(@form.el)

    return this
