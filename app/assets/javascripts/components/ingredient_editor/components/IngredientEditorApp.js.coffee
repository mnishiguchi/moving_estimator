IngredientItem = require('./IngredientItem')

# <IngredientEditorApp/> - The controller component

IngredientEditorApp = React.createClass
  mixins: [ Fluxxor.FluxMixin(React),
            Fluxxor.StoreWatchMixin("IngredientStore") ]

  # getInitialState: -> # none

  getStateFromFlux: ->
    flux = @getFlux()
    flux.store('IngredientStore').getState()

  render: ->

    createIngredientItems = (ingredients) =>
      for id, ingredient of ingredients
          <IngredientItem key={ id } ingredient={ ingredient } />

    <div>
      { createIngredientItems(@state.ingredients) }
    </div>

module.exports = IngredientEditorApp
