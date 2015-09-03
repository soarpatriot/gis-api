class V1::CommissionsApi < Grape::API

  namespace :commissions do
    desc "获取所有commissions", {
      entity: CommissionEntity
    }
    params do
    end
    get  do
      commissions = Commission.all
      present commissions, with: CommissionEntity
    end

  end
end
