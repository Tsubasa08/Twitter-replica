if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],     # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['AKIA5WUOR5DNGY3ICNM6'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['tsubasa-rails-st28']
  end
end