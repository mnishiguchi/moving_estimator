# FluxMixin = Fluxxor.FluxMixin(React)

# @PeopleSearch = React.createClass
#   mixins: [FluxMixin]

#   onSubmitSearch: (e) ->
#     e.preventDefault()

#     # Triggers an onFormSubmit event passing the user's input in the search box
#     searchValue = @refs.search.getDOMNode().value.trim()
#     @props.onFormSubmit(searchValue)

#   render: ->

#     <div className="filter-wrapper">
#       <div className="form-wrapper">
#         <form onSubmit={@onSubmitSearch}>
#           # The ref attribute can be referenced through @refs
#           <input ref="search"
#                  placeholder="Search people..."
#                  type="search"
#                  className="form-control"/>
#         </form>
#       </div>
#     </div>
