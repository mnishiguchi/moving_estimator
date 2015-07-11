constants = require('../constants/ingredient_constants')

IngredientActions =

  updateIngredient: (id, new_name) ->
    @dispatch(constants.UPDATE_INGREDIENT, id: id,
                                           new_name: new_name)
    params = ingredient:
               name: new_name
    $.ajax
      method: "PATCH"
      url:    "/ingredients/" + id,
      data:   params

    .done (data, textStatus, jqXHR) ->
      $.growl.notice title: "", message: "Ingredient suggestion updated"
    .fail (jqXHR, textStatus, errorThrown) ->
      $.growl.error title: "", message: "Error updating ingredient suggestion"
      console.error textStatus, errorThrown.toString()

  deleteIngredient: (id) ->
    @dispatch(constants.DELETE_INGREDIENT, id: id)
    $.ajax
      method: "DELETE"
      url:    "/ingredients/" + id
    .done (data, extStatus, jqXHR) ->
      $.growl.notice title: "", message: "Ingredient suggestion deleted"
    .fail (jqXHR, textStatus, errorThrown) ->
      $.growl.error title: "", message: "Error deleting ingredient suggestion"
      console.error textStatus, errorThrown.toString()

module.exports = IngredientActions
