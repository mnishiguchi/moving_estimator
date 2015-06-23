constants = require('../constants/ingredient_constants')

# Semantic actions

IngredientActions =

  updateIngredient: (ingredient, new_name) ->
    @dispatch(constants.UPDATE_INGREDIENT, ingredient: ingredient,
                                           new_name:   new_name)
    params = ingredient_suggestion:
               id:   ingredient.id
               name: new_name
    $.ajax
      method: "PATCH"
      url: "/ingredient_suggestions/" + ingredient.id
      data: params

    .done (data, textStatus, jqXHR) ->
      $.growl.notice title: "", message: "Ingredient suggestion updated"
    .fail (jqXHR, textStatus, errorThrown) ->
      $.growl.error title: "", message: "Error updating ingredient suggestion"
      console.error textStatus, errorThrown.toString()

  deleteIngredient: (ingredient) ->
    @dispatch(constants.DELETE_INGREDIENT, ingredient: ingredient)
    params = ingredient_suggestion:
               id: ingredient.id
    $.ajax
      method: "DELETE"
      url: "/ingredient_suggestions/" + ingredient.id
      data: params

    .done (data, extStatus, jqXHR) ->
      $.growl.notice title: "", message: "Ingredient suggestion deleted"
    .fail (jqXHR, textStatus, errorThrown) ->
      $.growl.error title: "", message: "Error deleting ingredient suggestion"
      console.error textStatus, errorThrown.toString()

module.exports = IngredientActions
