# Initialize with:
#   rake backup:run trigger='nrcanhockey-offsite'
backup 'nrcanhockey-offsite' do
  
  adapter :mysql do
    user        'cwise'
    password    'PCyvASHo86'
    database    'nrcanhockey_production'
  end
  
  storage :scp do
    ip        'www.murmurinfo.ca'
    user      'rbackup'
    password  'r3m0t3'
    path      './backups/'
  end
  
  keep_backups 10
  notify false
end

