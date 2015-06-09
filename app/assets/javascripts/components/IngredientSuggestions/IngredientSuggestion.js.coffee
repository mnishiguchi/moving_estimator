# The sub-component <IngredientSuggestion/>

@IngredientSuggestion = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  getInitialState: ->
    changed: false
    updated: false

  render: ->

    delete_button =
      <a href="#" onClick={@handleDelete}>
        <i className="fa fa-times"></i>
      </a>

    update_button =
      <span>
        <a href="#" onClick={@handleUpdate}
                    className="btn btn-primary btn-xs">
          Update
        </a>
        <a href="#" onClick={@handleCancelChange}
                    className="btn btn-default btn-xs">
          Cancel
        </a>
      </span>

    <div>
      { delete_button }
      <input onChange={@handleChange}
             ref="ingredient"
             defaultValue={@props.ingredient.name}/>
      { update_button if @state.changed }
    </div>

  handleChange: ->
    input = $(@refs.ingredient.getDOMNode()).val()
    original_name = @props.ingredient.name
    if input is original_name
    then @setState(changed: false)
    else @setState(changed: true)

  handleUpdate: (e) ->
    e.preventDefault()
    input = $(@refs.ingredient.getDOMNode()).val()
    @getFlux().actions.updateIngredient(@props.ingredient, input)
    @setState(changed: false, updated: true)

  handleDelete: (e) ->
    e.preventDefault()
    if confirm("Delete " + @props.ingredient.name + "?")
      @getFlux().actions.deleteIngredient(@props.ingredient)

  handleCancelChange: (e) ->
    e.preventDefault()
    $(@refs.ingredient.getDOMNode()).val(@props.ingredient.name)  # Restore the original value
    @setState(changed: false)
