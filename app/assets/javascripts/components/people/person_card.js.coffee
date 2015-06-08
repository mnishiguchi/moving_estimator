# FluxMixin = Fluxxor.FluxMixin(React)

# @PersonCard = React.createClass
#   mixins: [FluxMixin]

#   render: ->
#     # # let's use this add-on to set the main div's class names
#     # cx = React.addons.classSet
#     # # it will apply every key which value equals true to the className attribute
#     # cardClasses = cx
#     #   'card': true
#     #   'female': @props.data.gender == 'female'
#     #   'male': @props.data.gender == 'male'

#     # here we use the calculated classes
#     # <div className={cardClasses}>
#     <div className={cardClasses}>
#       <header>
#         <div className="avatar-wrapper">
#           &nbsp;
#           <img className="avatar" src={@props.data.picture} />
#         </div>
#         <div className="info-wrapper">
#           <h4>{@props.data.first_name} {@props.data.last_name}</h4>
#           <ul className="meta">
#             <li>
#               <i className="fa fa-map-marker"></i> {@props.data.location}
#             </li>
#             <li>
#               <i className="fa fa-birthday-cake"></i> {@props.data.birth_date}
#             </li>
#           </ul>
#         </div>
#       </header>
#       <div className="card-body">
#         <div className="headline">
#           <p>{@props.data.headline}</p>
#         </div>
#         <ul className="contact-info">
#           <li><i className="fa fa-phone"></i> {@props.data.phone_number}</li>
#           <li><i className="fa fa-envelope"></i> {@props.data.email}</li>
#         </ul>
#       </div>
#     </div>

# <div className="ms-item col-lg-4 col-md-6 col-sm-12">
#   <div className="person_card panel panel-primary">
#     <div className="panel-heading">
#       <div className="media">
#         <div className="media-left media-middle pull-left">
#           <div className="avatar-wrapper">
#             <img className="avatar" src="" />
#             {
#               if user.admin?
#                 <div className="center">
#                   <span className="badge">Admin</span>
#                 </div>
#             }
#             {
#               if @state.admin? && (current_user != user)
#               .center
#                 = link_to "delete", user_path(user), method: :delete,
#                   data: { confirm: "Are you sure?" }, style: "color: white;"
#             }

#           </div>
#         .info-wrapper.media-body
#           %h4.media-heading
#             = user.username

#           %ul.list-unstyled
#             %li
#               = fa_icon 'star', text: "Log in count:"
#               = user.sign_in_count
#             %li
#               = fa_icon 'star', text: "Since:"
#               = user.created_at.strftime("%B %Y")

#     .person_sentence.panel-body
#       %i
#         = Faker::Lorem.sentence(3)

#     .contact-info.panel-footer
#       %ul.list-unstyled.list-inline
#         %li
#           = fa_icon 'envelope'
#           = user.email

#         </div>
#       </div>
#     </div>
#   </div>
# </div>
