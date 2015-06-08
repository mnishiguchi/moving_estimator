# # Constants (Action types)

# constants =
#   FETCH_USERS: 'FETCH_USERS'
#   DELETE_USER: 'DELETE_USER'

# # Stores

# UsersStore = Fluxxor.createStore
#   initialize: ->
#     @admin = false  # TODO pass in from Rails
#     @users = []
#     @bindActions(constants.FETCH_USERS, @onFetchUsers,
#                  constants.DELETE_USER, @onDeleteUser)

#   onFetchUsers: ->
#     @emit('change')

#   onDeleteUser: (payload) ->
#     id = payload.id  # Provides React to user's id
#     @emit('change')

#   getState: ->
#     users: @users

# # Registering our semantic actions

# actions =
#   fetchUsers: ->
#     @dispatch(constants.FETCH_USERS)
#     # AJAX

#   deleteUser: (id) ->
#     @dispatch(constants.DELETE_USER, id: id)
#     # AJAX

# # Instantiating our stores

# stores =
#   UsersStore: new UsersStore

# # Creating a Flux instance with our stores and actions that are defined above

# flux = new Fluxxor.Flux(stores, actions)

# # Logging upon the "dispatch" event

# flux.on 'dispatch', (type, payload) ->
#   console.log "[Dispatch]", type, payload if console?.log?

# # The main React component (<PeopleSection/>)

# FluxMixin = Fluxxor.FluxMixin(React)
# StoreWatchMixin = Fluxxor.StoreWatchMixin

# @PeopleSection = React.createClass
#   mixins: [FluxMixin, StoreWatchMixin("UsersStore")]

#   # Provides the initial state for the render method
#   getInitialState: ->
#     didFetchData: false  # We'll change it to true once we fetch data
#     searchText:   ""     # The users JSON array used to display the cards in the view

#   getStateFromFlux: ->
#     flux = @getFlux()
#     flux.store('UsersStore').getState()

#   # AJAX call to our UsersController
#   _fetchUsers: (data) ->
#     $.ajax
#       url:      "/users.json"
#       dataType: 'json'
#       data:     data
#     .done @_fetchDataDone
#     .fail @_fetchDataFail

#   # On successful AJAX call
#   _fetchDataDone: (data, textStatus, jqXHR) ->
#     # We change the state of the component.
#     # This will cause the component and its children to re-render
#     @setState
#       didFetchData: true
#       people: data

#   # On unsuccessful AJAX call
#   _fetchDataFail: (xhr, status, err) =>
#     console.error @props.url, status, err.toString()

#   # Handler for the submit event on the PeopleSearch component
#   _handleOnSearchSubmit: (search) ->
#     # Fetch people based on the user's input
#     @_fetchUsers
#       search: search

#   # The component will be rendered depending on its props and state
#   render: ->

#     # personCard component with a data property containing all the JSON
#     # attributes we are going to use to display it to the user
#     cardsNode = @state.users.map (user) ->

#       <personCard key={user.id} data={user}/>

#     # Displayed if no people found in it's state
#     noDataNode =
#       <div className="warning">
#         <span className="fa-stack">
#           <i className="fa fa-meh-o fa-stack-2x"></i>
#         </span>
#         <h4>No people found...</h4>
#       </div>

#     # The main HTML

#     <div>
#       <PeopleSearch onFormSubmit={@_handleOnSearchSubmit}/>

#       <div className="cards-wrapper">
#         {
#           if @state.people.length > 0
#             {cardsNode}
#           else if @state.didFetchData
#             {noDataNode}
#         }
#       </div>
#     </div>

# # Rendering the whole component upon page-change
# $(document).on "page:change", ->
#   React.render <PeopleSection flux={flux} />,
#                 document.getElementById("react_PeopleSection")
