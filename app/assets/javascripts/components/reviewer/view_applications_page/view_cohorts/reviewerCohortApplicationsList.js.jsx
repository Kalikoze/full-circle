class ReviewerCohortApplicationList extends React.Component {
  
  reviewStatus(app) {
    if (this.findUserReview(app)) {
      return this.findUserReview(app).status
    } else {
      return "N/A"
    }
  }
  
  totalScore(app) {
    if (this.findUserReview(app)) {
      return this.findUserReview(app).score_card.total
    } else {
      return "N/A"
    }
  }
  
  findCohortReviewer(app, review) {
    return this.props.user.cohort_reviewers.find((ch_reviewer) => {
      return ch_reviewer.id == review.cohort_reviewer_id
    })
  }
  
  findUserReview(app){
    return app.reviews.find((review) => {
      return review.cohort_reviewer_id == this.findCohortReviewer(app, review).id;
    })
  }

  render() {
    return(
      <section className='cohort-applications-list'>
        <StaticTextField
          key={this.props.cohort + ' application-list-headers'}
          name='application'
          texts={['Application', 'Status', 'Total Score']}
          color='rgba(0, 187, 210, 1)'
          width='100%' />
        {this.props.applications.map((app) => {
          return <SelectableTextField
            key={app.id}
            texts={[app.id, this.reviewStatus(app), this.totalScore(app)]}
            width='100%'
            returnKey='application'
            returnValue={app}
            handleAction={this.props.handleAction} />
        })}
      </section>
    )
  }
}