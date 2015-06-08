@PeopleSearch = React.createClass
  displayName: 'PeopleSearch'

  # Submit handler
  _handleOnSubmit: (e) ->
    e.preventDefault()

    # the value of the search box input
    searchValue = @refs.search.getDOMNode().value.trim()

    # triggers it's custom onFormSubmit event passing searchValue
    @props.onFormSubmit(searchValue)

  render: ->
    <div className="filter-wrapper">
      <div className="form-wrapper">
        <form onSubmit={@_handleOnSubmit}>
          # ref attribute is used to reference elements in the
          # component by @refs
          <input ref="search" placeholder="Search people..." type="search"/>
        </form>
      </div>
    </div>
