class AdminCohortApplicationList extends React.Component {

  render() {
    return(
      <section className='cohort-applications-list'>
        {this.props.applications.map((app) => {
          return <SelectableTextField
            key={app.user.id}
            texts={[app.user.name, app.status]}
            width='100%'
            returnKey='application'
            returnValue={app}
            handleAction={this.props.handleAction} />
        })}
      </section>
    )
  }
}