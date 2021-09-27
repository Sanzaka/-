set :output, "log/crontab.log"
set :environment, :production

every 1.day, at: "07:00 am" do
  runner "Batch::DataCreate.target_create"
end

every 1.day, at: "07:00 pm" do
  runner "Batch::DataCreate.result_create"
end
