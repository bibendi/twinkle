# frozen_string_literal: true
class GithubAuthorize < ApplicationInteractor
  params :user, :organization, :team

  validates :user, :organization, presence: true

  private

  def perform
    if user.api.org_member?(organization)
      return unless team
      return if user.api.team_member?(organization, team)

      context.fail!(message: t("errors.messages.not_team_member"))
    else
      context.fail!(message: t("errors.messages.not_organization_member"))
    end
  end
end
