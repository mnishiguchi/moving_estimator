@PersonCard = React.createClass
  displayName: 'PersonCard'
  render: ->
    # let's use this add-on to set the main div's class names
    cx = React.addons.classSet
    # it will apply every key which value equals true
    # to the className attribute
    cardClasses = cx
      'card': true
      'female': @props.data.gender == 'female'
      'male': @props.data.gender == 'male'

    # here we use the calculated classes
    <div className={cardClasses}>
      <header>
        <div className="avatar-wrapper">
          &nbsp;
          <img className="avatar" src={@props.data.picture} />
        </div>
        <div className="info-wrapper">
          <h4>{@props.data.first_name} {@props.data.last_name}</h4>
          <ul className="meta">
            <li>
              <i className="fa fa-map-marker"></i> {@props.data.location}
            </li>
            <li>
              <i className="fa fa-birthday-cake"></i> {@props.data.birth_date}
            </li>
          </ul>
        </div>
      </header>
      <div className="card-body">
        <div className="headline">
          <p>{@props.data.headline}</p>
        </div>
        <ul className="contact-info">
          <li><i className="fa fa-phone"></i> {@props.data.phone_number}</li>
          <li><i className="fa fa-envelope"></i> {@props.data.email}</li>
        </ul>
      </div>
    </div>
