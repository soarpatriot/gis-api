class V1::CommissionsApi < Grape::API
  
  before do 
    key_authenticate!
  end 
  params do 
    requires :app_key, type: String
  end
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
